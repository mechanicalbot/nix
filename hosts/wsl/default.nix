{
  config,
  pkgs,
  modulesPath,
  ...
}:
let
  username = "dev";
in
{
  system.stateVersion = "25.11";

  imports = [
    ../../modules/shared
    ../../modules/wsl
  ];

  x.wsl.enable = true;
  x.wsl.username = username;

  networking.hostName = "wsl";

  users.users.${username} = {
    openssh.authorizedKeys.keyFiles = [
      (builtins.fetchurl {
        url = "https://github.com/mechanicalbot.keys";
        sha256 = "0gmxlc764vl90hk6v3hfij0m75v6v7ndzgrz6mmpq2inm242jiy7";
      })
    ];
  };

  services.openssh = {
    enable = true;
  };

  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    htop
    btop
    gdu
    duf
    iperf
    dig
  ];

  environment.shellAliases = {
    switch = "sudo nixos-rebuild switch";
    deploy = "${pkgs.deploy-rs}/bin/deploy";
  };

  programs = {
    lazygit = {
      enable = true;
      settings = {
        gui = {
          splitDiff = "always";
        };
        git = {
          pagers = [
            {
              pager = "${pkgs.ydiff}/bin/ydiff -p cat -s --wrap --width={{columnWidth}}";
              colorArg = "never";
              externalDiffCommand = "${pkgs.difftastic}/bin/difft --color=always";
            }
            {
              pager = "${pkgs.diff-so-fancy}/bin/diff-so-fancy";
            }
            {
              pager = "${pkgs.delta}/bin/delta --dark --paging=never";
            }
          ];
        };
      };
    };
  };
}
