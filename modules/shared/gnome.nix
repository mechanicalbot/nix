{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    mod.gnome = {
      enable = lib.mkEnableOption "Enable Gnome";
    };
  };

  config = lib.mkIf config.mod.gnome.enable {
    services.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      gnomeExtensions.just-perfection
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-panel
      gnomeExtensions.arc-menu
      gnomeExtensions.paperwm
      gnomeExtensions.user-themes
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.vitals
    ];
  };
}
