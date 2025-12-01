{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nix-deploy = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/nix-deploy ];
    };
  };
}
