{
  config,
  pkgs,
  modulesPath,
  ...
}:
{
  system.stateVersion = "25.11";

  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../modules/shared
  ];

  proxmoxLXC = {
    privileged = true;
    manageNetwork = false;
    manageHostName = false;
  };

  programs.nix-ld.enable = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    lazydocker
    git
    htop
    btop
    gdu
    duf
  ];

  fileSystems."/mnt/truenas/immich/library" = {
    device = "192.168.1.30:/mnt/tank/immich/library";
    fsType = "nfs";
    options = [
      # "x-systemd.automount"
      # "noauto"
      "x-systemd.mount-timeout=90"
    ];
  };
}
