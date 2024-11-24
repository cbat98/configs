# home.nix
{
  config,
  pkgs,
  ...
}: let
  configDir = /home/charlie/repos/configs;
in {
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.charlie = {pkgs, ...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        monitors = {
          monitor = ",preferred,auto,auto";
        };
        bind = [
          "$mod, Q, exec, kitty"
        ];
        general = {
          "gaps_in" = 5;
          "gaps_out" = 20;
          "border_size" = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          "resize_on_border" = false;
          "allow_tearing" = false;
          "layout" = "dwindle";
        };
        decoration = {
          "rounding" = 10;

          "active_opacity" = 1.0;
          "inactive_opacity" = 1.0;

          shadow = {
            "enabled" = true;
            "range" = 4;
            "render_power" = 3;
            "color" = "rgba(1a1a1aee)";
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          "blur" = {
            "enabled" = true;
            "size" = 3;
            "passes" = 1;

            "vibrancy" = 0.1696;
          };
        };
      };
    };
    home = {
      username = "charlie";
      homeDirectory = "/home/charlie";
      packages = with pkgs; [
        alejandra
        alsa-utils
        cargo
        deno
        dolphin
        dotnetCorePackages.dotnet_8.sdk
        fastfetch
        fd
        gccgo14
        jq
        lazygit
        lf
        neovim
        nixd
        nodejs_20
        pavucontrol
        ripgrep
        tldr
        unzip
        waybar
        wofi
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
