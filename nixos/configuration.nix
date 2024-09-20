# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #
  # --- Meta Options -------------------------------------------
  #

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking = {
    hostName = "charlie-nixlt";
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

  services.blueman.enable = true;
  #
  # --- Pre Startup --------------------------------------------
  #


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

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  services.resolved.enable = true;

  services.libinput.touchpad.naturalScrolling = true;
  #
  # --- Services -----------------------------------------------
  #

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    videoDrivers = [ "intel" ];
    xkb = {
      layout = "gb";
      variant = "";
    };
  };

  services.picom.enable = true;

  services.displayManager.defaultSession = "none+i3";

  console.keyMap = "uk";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #
  # --- User Configuration -------------------------------------
  #
  users.users.charlie = {
    isNormalUser = true;
    description = "Charlie B";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
  };

  security.pki.certificateFiles = [
    ./cert.pem
  ];

  security.sudo = {
    enable = true;
    extraConfig = ''
      %wheel ALL=(ALL) NOPASSWD: ALL
    '';
  };

  services.getty.autologinUser = "charlie";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    rquickshare
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];


  services.openssh.enable = true;


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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
