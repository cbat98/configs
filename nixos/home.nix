# home.nix

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { };
  configDir = /home/charlie/repos/configs;
in
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.charlie = { pkgs, ... }: {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        fonts = {
          names = [
            "Monaspace Neon"
          ];
          style = "Normal";
          size = 8.0;
        };
        modes = {
          resize = {
            Down = "resize grow height 5 px or 5 ppt";
            Escape = "mode default";
            Left = "resize shrink width 5 px or 5 ppt";
            Return = "mode default";
            Right = "resize grow width 5 px or 5 ppt";
            Up = "resize shrink height 5 px or 5 ppt";
          };
        };
        modifier = "Mod4";
        gaps = {
          inner = 10;
          outer = 2;
        };
        terminal = "kitty";
      };
    };
    home = {
      username = "charlie";
      homeDirectory = "/home/charlie";
      packages = with pkgs; [
        alsa-utils
        cargo
        deno
        fastfetch
        fd
        gccgo14
        jq
        lazygit
        lf
        unstable.neovim
        nodejs_20
        pavucontrol
        ripgrep
        tldr
        unzip
        xclip
        dotnetCorePackages.dotnet_8.sdk
      ];
      sessionVariables = {
        GTK_THEME = "Adwaita-dark";
      };
      stateVersion = "24.05";
    };
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          cat = "bat";
          fs = "du -h --max-depth=1";
          lg = "lazygit";
          ll = "eza -la";
          lt = "eza -TL 2";
        };
        initExtra = ''
          	  eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init bash --config ${configDir}/oh-my-posh/material-edit.omp.json)"
          	'';
      };
      bat.enable = true;
      btop.enable = true;
      eza = {
        enable = true;
        enableBashIntegration = true;
        git = true;
      };
      firefox = {
        enable = true;
        policies = {
          OfferToSaveLogins = false;
        };
      };
      git = {
        enable = true;
        extraConfig = {
          user.name = "Charlie B";
          user.email = "charlie@charliebatten.co.uk";
          pull.rebase = true;
          init.defaultBranch = "main";
        };
      };
      kitty = {
        enable = true;
        font = {
          package = pkgs.monaspace;
          name = "Monaspace Neon";
          size = 11;
        };
        extraConfig = ''
                    background_opacity 0.8
                    enable_audio_bell no
          	'';
      };
    };
  };
}
