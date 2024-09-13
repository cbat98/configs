# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
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

  # Configure X11
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

  # Configure PipeWire for audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.charlie = {
    isNormalUser = true;
    description = "Charlie B";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
    # packages = with pkgs; [ ];
  };

  security.pki.certificates = [
  ''
-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----
  ''
  ];

  security.sudo = {
    enable = true;
    extraConfig = ''
      %wheel ALL=(ALL) NOPASSWD: ALL
    '';
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "charlie";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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
