{ config, pkgs, userConfig, ... }:

let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --remember-user-session --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
  session = "start-hyprland";
in {
  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    resolved.enable = true;
    openssh.enable = true;
    blueman.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "intel" "nvidia" ];
      xkb = {
        layout = "gb";
        variant = "";
      };
    };

    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${session}";
          user = userConfig.username;
        };
        default_session = {
          command = "${tuigreet} --cmd ${session}";
          user = "greeter";
        };
      };
    };

    libinput.touchpad.naturalScrolling = true;
  };
}
