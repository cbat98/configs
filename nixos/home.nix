# home.nix
{
  config,
  pkgs,
  ...
}: let
  configDir = /home/charlie/repos/configs;
  wallpaperUrl = "https://i.redd.it/xjhfbx66k0b91.png";
  wallpaper = pkgs.fetchurl {
    url = wallpaperUrl;
    name = "wallpaper.png";
    hash = "sha256-B0H0vxJW66TnTDgzQ4JaVqxHfsT4xo0ZcBK3btJ4jr4=";
  };
in {
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.charlie = {pkgs, ...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$fileManager" = "thunar";
        exec-once = [
          "waybar"
          "nm-applet"
          "blueman-applet"
          # Add other autostart programs here, e.g., "dunst" for notifications
        ];
        monitor = [
          "eDP-1,1920x1080,0x0,1"
          ",preferred,auto,1"
        ];
        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "GTK_THEME,Adwaita-dark"
          "CLUTTER_DEFAULT_THEME,Adwaita-dark"
        ];
        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 2;
          "col.active_border" = "rgba(f92672ff) rgba(a6e22eff) 45deg"; # Red -> Green
          "col.inactive_border" = "rgba(75715eff)";
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
            color = "rgba(00000099)";
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
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
          focus_on_activate = true;
        };
        input = {
          kb_layout = "gb";
          follow_mouse = 1;
          sensitivity = 0.7;
          accel_profile = "flat";
          mouse_refocus = 0;
          repeat_rate = 25;
          repeat_delay = 600;
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
        layerrule = [
          "blur, waybar"
        ];
        bind = [
          "$mod, RETURN, exec, $terminal"
          "$mod, C, killactive, "
          "$mod, M, exit, "
          "$mod, E, exec, $fileManager"
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
        dotnet-sdk_9
        fastfetch
        fd
        feh
        gccgo14
        gnome-icon-theme
        inkscape
        jq
        lazygit
        lf
        neovim
        nixd
        nodejs_20
        pavucontrol
        pamixer
        prusa-slicer
        qbittorrent
        ripgrep
        simple-scan
        tldr
        unzip
        vlc
        wl-clipboard
        xfce.thunar
        zip
      ];
      stateVersion = "24.05";
    };
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          fs = "du -h --max-depth=1";
          lg = "lazygit";
          ll = "eza -la";
          lt = "eza -TL 2";
        };
        initExtra = ''
          eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init bash --config ${configDir}/oh-my-posh/material-edit.omp.json)"
        '';
      };
      btop.enable = true;
      eza = {
        enable = true;
        enableBashIntegration = true;
        git = true;
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
        style = ''
          * {
            border: none;
            border-radius: 0;
            font-family: "Monaspace Neon";
            font-size: 13px;
            min-height: 0;
          }
          window#waybar {
            background: #272822; /* Monokai background */
            color: #f8f8f2; /* Monokai foreground */
            opacity: 0.9;
          }
          #workspaces {
            background: #3e3d32; /* Slightly lighter background */
            color: #f8f8f2;
            padding: 0px 10px;
            margin: 3px 5px;
            border-radius: 10px;
          }
          #workspaces button {
            padding: 0px 5px;
            color: #75715e; /* Comment color */
            background: transparent;
            border: none;
            border-radius: 5px;
          }
          #workspaces button.active {
            color: #f8f8f2;
          }
          #workspaces button.occupied {
            color: #a6e22e; /* Green */
          }
          #window {
            background: transparent;
            color: #f8f8f2;
            padding: 0px 10px;
            margin: 3px 5px;
          }
          #pulseaudio, #network, #battery, #clock, #cpu, #memory, #idle_inhibitor, #custom-updates {
            background: #3e3d32; /* Slightly lighter background */
            color: #f8f8f2;
            padding: 0px 10px;
            margin: 3px 5px;
            border-radius: 10px;
          }
          #pulseaudio.muted {
              color: #f92672; /* Red */
          }
          #battery.discharging {
            color: #e6db74; /* Yellow */
          }
          #battery.critical:not(.charging) {
              color: #f92672; /* Red */
          }
        '';
        settings = {
          mainBar = {
            spacing = 10;
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
              "cpu"
              "memory"
              "clock"
            ];
            "battery" = {
              format = " {capacity}%";
              format-charging = " {capacity}%";
              format-plugged = " {capacity}%";
              format-alt = "{time}";
              states = {
                warning = 30;
                critical = 15;
              };
              weighted-average = true;
            };
            "clock" = {
              interval = 1;
              format = "󰥔 {:%d/%m/%Y %H:%M:%S}";
              tooltip = false;
            };
            "network" = {
              format = "󰤨 {ipaddr} ({essid})";
            };
            "pulseaudio" = {
              format = " {volume}%";
              format-muted = " MUTE";
              on-click = "pavucontrol";
            };
            "hyprland/workspaces" = {
              disable-scroll = true;
              active-only = false;
            };
            "cpu" = {
              format = "󰍛 {usage}%";
              interval = 1;
            };
            "memory" = {
              format = "󰍈 {percentage}%";
              interval = 1;
            };
          };
        };
      };
    };
    programs.wofi = {
      enable = true;
      style = ''
        window {
          margin: 0px;
          border: 2px solid rgba(117, 113, 94, 0.5); /*Comment Color Border*/
          background-color: rgba(39, 40, 34, 0.9); /* Monokai background */
          color: #f8f8f2; /* Monokai foreground */
          font-family: "Monaspace Neon";
          font-size: 14px;
        }

        #input {
          margin: 5px;
          border: none;
          color: #f8f8f2; /* Monokai foreground */
          background-color: rgba(54, 56, 48, 0.9); /*Slightly Lighter Background*/
          padding: 5px;
        }

        #inner-box {
          margin: 5px;
          border: none;
        }

        #scroll {
          margin: 0px;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: #f8f8f2; /* Monokai foreground */
        }

        #entry:selected {
          background-color: rgba(102, 217, 239, 0.9); /*Blue*/
          color: #272822; /* Monokai background */
        }
      '';
      settings = {
        width = 500;
        height = 500;
        anchor = "center";
        gtk-dark = true;
        allow-images = true;
        dmenu = true;
        sort = true;
        insensitive = true;
        matching = "fuzzy";
      };
    };
    services.hyprpaper = {
      enable = true;
      settings = {
        "preload" = ["${wallpaper}"];
        "wallpaper" = ["eDP-1,${wallpaper}"];
        "splash" = false;
      };
    };
  };
}
