{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;

        font-size: 14px;
        min-height: 0;
      }
      window#waybar {
        background: #272822;
        color: #f8f8f2;
        opacity: 0.9;
      }
      #workspaces {
        background: #3e3d32;
        color: #f8f8f2;
        padding: 0px 10px;
        margin: 3px 5px;
        border-radius: 10px;
      }
      #workspaces button {
        padding: 0px 5px;
        color: #75715e;
        background: transparent;
        border: none;
        border-radius: 5px;
      }
      #workspaces button.active {
        color: #f8f8f2;
      }
      #workspaces button.occupied {
        color: #a6e22e;
      }
      #window {
        background: transparent;
        color: #f8f8f2;
        padding: 0px 10px;
        margin: 3px 5px;
      }
      #pulseaudio, #network, #battery, #clock, #cpu, #memory, #idle_inhibitor, #custom-updates, #tray {
        background: #3e3d32;
        color: #f8f8f2;
        padding: 0px 10px;
        margin: 3px 3px;
        border-radius: 10px;
      }
      #pulseaudio.muted {
          color: #f92672;
      }
      #battery.discharging {
        color: #f8f8f2;
      }
      #battery.warning {
        color: #e6db74;
      }
      #battery.critical:not(.charging) {
          color: #f92672;
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
          "network"
          "pulseaudio"
          "battery"
          "cpu"
          "memory"
          "clock"
          "tray"
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
          format = "  {volume}%";
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
        "tray" = {
          "icon-size" = 18;
          "spacing" = 9;
        };
      };
    };
  };
}
