{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      disko,
      deploy-rs,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations.nix-deploy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/nix-deploy ];
      };

      nixosConfigurations.nix-0 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hosts/nix-0
        ];
      };

      deploy.nodes.nix-0 = {
        hostname = "192.168.1.76";
        sshUser = "dev";
        user = "root";
        interactiveSudo = true;
        profiles.system = {
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nix-0;
        };
      };
    };
}
