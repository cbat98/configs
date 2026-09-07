{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Inter", "CaskaydiaCove Nerd Font", sans-serif;
        font-size: 15px;
        min-height: 0;
      }
      window#waybar {
        background: rgba(39, 40, 34, 0.9);
        color: #f8f8f2;
      }
      #workspaces {
        background: #424137;
        margin: 4px 4px;
        padding: 0px 5px;
        border-radius: 10px;
      }
      #workspaces button {
        padding: 0px 5px;
        color: #75715e;
      }
      #workspaces button.active {
        color: #f8f8f2;
      }
      #workspaces button.urgent {
        color: #f92672;
      }
      #window {
        margin: 4px 4px;
        padding: 0px 10px;
        background: #424137;
        border-radius: 10px;
      }
      #network, #pulseaudio, #backlight, #battery, #cpu, #memory, #clock, #tray {
        padding: 0px 10px;
      }
      .modules-right > widget > box {
        background: #424137;
        margin: 4px 2px;
        padding: 0px 5px;
        border-radius: 10px;
      }
      #pulseaudio.muted {
        color: #f92672;
      }
      #battery.warning {
        color: #e6db74;
      }
      #battery.critical:not(.charging) {
        color: #f92672;
      }
      #clock {
        color: #a6e22e;
      }
    '';
    settings = {
      mainBar = {
        spacing = 4;
        layer = "top";
        position = "top";
        height = 34;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "group/system"
          "group/hardware"
          "clock"
          "tray"
        ];

        "group/system" = {
          orientation = "horizontal";
          modules = [
            "network"
            "pulseaudio"
            "backlight"
            "battery"
          ];
        };

        "group/hardware" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "memory"
          ];
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{name}";
        };

        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  {ipaddr}";
          format-disconnected = "󰤮  Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
        };

        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟  MUTE";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
        };

        "backlight" = {
          format = "{icon}  {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰂄  {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        "cpu" = {
          format = "󰍛  {usage}%";
          interval = 2;
        };

        "memory" = {
          format = "󰍈  {percentage}%";
          interval = 2;
        };

        "clock" = {
          format = "󰥔  {:%H:%M:%S} ";
          format-alt = "󰃭  {:%d/%m/%Y} ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 1;
        };

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
  };
}
