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
        exec-once = [
          "waybar"
        ];
        monitor = [
          "eDP-1,1920x1080,0x0,1"
          ",preferred,auto,1"
        ];
        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
        ];
        general = {
          gaps_in = 2;
          gaps_out = 1;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };
        decoration = {
          rounding = 5;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            "render_power" = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "master";
        };
        misc = {
          force_default_wallpaper = 1;
          disable_hyprland_logo = false;
        };
        input = {
          kb_layout = "gb";
          follow_mouse = 1;
          sensitivity = 0.7;
          accel_profile = "flat";
          mouse_refocus = 0;
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };
        };
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };
        device = {
          name = "tpps/2-ibm-trackpoint";
          sensitivity = 0.3;
        };
        bind = [
          "$mod, RETURN, exec, kitty"
          "$mod, C, killactive, "
          "$mod, M, exit, "
          "$mod, E, exec, nemo"
          "$mod, V, togglefloating, "
          "$mod, R, exec, wofi --show drun"
          "$mod, B, togglesplit, "
          "$mod, F, fullscreen"
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, L, movewindow, r"
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"
          ",XF86AudioMute, exec, pamixer -t"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        binde = [
          ",XF86AudioLowerVolume, exec, pamixer -d 2"
          ",XF86AudioRaiseVolume, exec, pamixer -i 2"
        ];
      };
    };
    home = {
      username = "charlie";
      homeDirectory = "/home/charlie";
      packages = with pkgs; [
        alejandra
        alsa-utils
        brightnessctl
        cargo
        deno
        dotnetCorePackages.dotnet_8.sdk
        fastfetch
        fd
        gccgo14
        jq
        lazygit
        lf
        nemo
        neovim
        nixd
        nodejs_20
        pavucontrol
        pamixer
        ripgrep
        tldr
        unzip
        vlc
        wl-clipboard
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
          size = 12;
        };
        extraConfig = ''
          background_opacity 0.8
          enable_audio_bell no
        '';
      };
      waybar = {
        enable = true;
        settings = {
          mainBar = {
            spacing = 20;
            layer = "top";
            position = "top";
            height = 30;
            output = [
              "*"
            ];
            modules-left = [
              "hyprland/workspaces"
            ];
            modules-center = [
              "hyprland/window"
            ];
            modules-right = [
              "pulseaudio"
              "network"
              "battery"
              "clock"
            ];
            "battery" = {
              format = "BAT: {capacity}%";
              weighted-average = true;
            };
            "clock" = {
              interval = 1;
              format = "{:%H:%M:%S %d/%m/%Y}";
              tooltip = false;
            };
            "network" = {
              format = "{ipaddr} ({essid})";
            };
            "pulseaudio" = {
              format = "VOL: {volume}%";
              format-muted = "VOL: MUTE";
              on-click = "pavucontrol";
            };
          };
        };
      };
    };
  };
}
