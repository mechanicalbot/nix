{
  config,
  pkgs,
  modulesPath,
  ...
}:
let
  hostname = "desktop";
  username = "dev";
in
{
  system.stateVersion = "25.11";

  imports = [
    ../../modules/shared
    ./hardware-configuration.nix
    ./disko.nix
  ];

  environment.shellAliases = {
    switch = "sudo nixos-rebuild switch";
    deploy = "${pkgs.deploy-rs}/bin/deploy";
  };

  mod.nvidia.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.flatpak.enable = true;
  services.displayManager.gdm.enable = true;

  mod.gnome.enable = true;

  mod.audio.enable = true;

  nix.settings.trusted-users = [ "@wheel" ];
  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = "${../../home}/${username}@${hostname}";
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.steam = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    wget
  ];
}
