{ config, pkgs, ... }:
{
  home.stateVersion = "25.11";
  home.username = "dev";
  home.homeDirectory = "/home/dev";

  home.packages = with pkgs.unstable; [
    code-cursor
    vscode
    brave
    bitwarden-desktop
    htop
    btop
    gdu
    duf
    lazygit
    lazydocker
    mise
    nixd
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -S "$HOME/.bitwarden-ssh-agent.sock" ]; then
        export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
      fi
    '';
  };
}
