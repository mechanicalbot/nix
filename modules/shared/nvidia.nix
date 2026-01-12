{ lib, config, ... }:
{
  options = {
    mod.nvidia = {
      enable = lib.mkEnableOption "Enable Nvidia";
    };
  };

  config = lib.mkIf config.mod.nvidia.enable {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
    };
    systemd.services.nvidia-suspend.enable = true;
    systemd.services.nvidia-resume.enable = true;
    systemd.services.nvidia-hibernate.enable = true;
  };
}
