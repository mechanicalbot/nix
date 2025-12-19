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

  environment.systemPackages = with pkgs; [
    htop
    btop
    gdu
    duf
  ];

  proxmoxLXC.privileged = true;
  nix.settings.sandbox = false;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
