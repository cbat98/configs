# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --remember-user-session --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
  session = "start-hyprland";
  username = "charlie";
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     antigravity = prev.callPackage ./overlays/antigravity/package.nix { };
  #   })
  # ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      charlie = import ./home.nix;
    };
  };

  #
  # --- Meta Options -------------------------------------------
  #

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  #
  # --- Pre Startup --------------------------------------------
  #

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #
  # --- System Config ------------------------------------------
  #

  hardware.nvidia.open = true;
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console.keyMap = "uk";

  networking = {
    hostName = "charlie-nixlt02";
    enableIPv6 = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
    };
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  security.sudo = {
    enable = true;
    extraConfig = ''
      %wheel ALL=(ALL) NOPASSWD: ALL
    '';
  };

  boot.tmp.cleanOnBoot = true;

  boot.kernelParams = ["mem_sleep_default=deep"];

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    linux-firmware
    vim
  ];
  
  #
  # --- Virtualisation -----------------------------------------
  #

  virtualisation.docker.enable = true;

  #
  # --- Services -----------------------------------------------
  #

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.resolved.enable = true;
  services.openssh.enable = true;
  services.blueman.enable = true;

  services.getty.autologinUser = "charlie";

  services.xserver = {
    enable = true;
    videoDrivers = ["intel" "nvidia"];
    xkb = {
      layout = "gb";
      variant = "";
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command = "${tuigreet} --cmd ${session}";
        user = "greeter";
      };
    };
  };

  services.displayManager.defaultSession = "hyprland";

  services.libinput.touchpad.naturalScrolling = true;

  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };

  #
  # --- User Configuration -------------------------------------
  #

  users = {
    users.charlie = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
      ];
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

