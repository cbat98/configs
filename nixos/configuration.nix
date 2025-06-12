# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "charlie";
in {
  imports = [
    ./hardware-configuration.nix
    ./home.nix
  ];

  #
  # --- Meta Options -------------------------------------------
  #

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #
  # --- System Config ------------------------------------------
  #

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
    hostName = "charlie-nixlt";
    enableIPv6 = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        9100
      ];
    };
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.hplipWithPlugin
      pkgs.sane-airscan
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

  environment.systemPackages = with pkgs; [
    firefox
    linux-firmware
    prusa-slicer
    vim
  ];

  #
  # --- Services -----------------------------------------------
  #

  services.resolved.enable = true;
  services.openssh.enable = true;
  services.getty.autologinUser = "charlie";

  services.xserver = {
    enable = true;
    videoDrivers = ["intel"];
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
        command = "${tuigreet} --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };

  services.prometheus.exporters = {
    node = {
      enable = true;
      enabledCollectors = ["systemd"];
    };
  };

  services.displayManager.defaultSession = "hyprland";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    daemon = {
      settings = {
        userland-proxy = false;
        experimental = true;
        ipv6 = false;
      };
    };
  };

  services.upower = {
    enable = true;
    percentageCritical = 10;
    percentageAction = 10;
    criticalPowerAction = "Hibernate";
  };

  services.libinput.touchpad.naturalScrolling = true;

  services.blueman.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplipWithPlugin
    ];
  };

  #
  # --- User Configuration -------------------------------------
  #

  users.users.charlie = {
    isNormalUser = true;
    description = "Charlie B";
    extraGroups = [
      "docker"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
