{ lib, config, ... }:
{
  options = {
    mod.audio = {
      enable = lib.mkEnableOption "Enable audio";
    };
  };

  config = lib.mkIf config.mod.audio.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
