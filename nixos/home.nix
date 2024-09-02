# home.nix

{ config, pkgs, ... }:

let
  unstablePkgs = import <nixos-unstable> {};
  configDir = /home/charlie/repos/configs;
in
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.charlie = { pkgs, ... }: {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";
	gaps = {
	  inner = 10;
	  outer = 5;
	};
	terminal = "kitty";
      };
    };
    home = {
      username = "charlie";
      homeDirectory = "/home/charlie";
      packages = with pkgs; [
	alsa-utils
	deno
        fastfetch
	lazygit
	unstablePkgs.neovim
	nodejs_20
	pavucontrol
	ripgrep
        tldr
	unzip
	xclip
      ];
      stateVersion = "24.05";
    };
    programs = {
      bash = {
        enable = true;
	enableCompletion = true;
	shellAliases = {
	  cat = "bat";
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
	  AppAutoUpdate = true;
	  DisableTelemetry = true;
	  DisableFirefoxStudies = true;
	  EnableTrackingProtection = {
	    Value = true;
	    Locked = true;
	    Cryptomining = true;
	    Fingerprinting = true;
	  };
	  DisablePocket = true;
	  DisableFirefoxScreenshots = true;
	  OverrideFirstRunPage = "";
	  DisplayBookmarksToolbar = "never";
	  DisplayMenuBar = "default-off";
	  SearchBar = "unified";
	  HardwareAcceleration = true;
	  ExtensionSettings = {
	    # "*".installation_mode = "blocked";
	    "uBlock0@raymondhill.net" = {
	      install_url = "https://addons.mozilla.org/firefox/downloads/file/4328681/ublock_origin-1.59.0.xpi";
	      installation_mode = "force_installed";
	    };
	    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
	      install_url = "https://addons.mozilla.org/firefox/downloads/file/4326285/bitwarden_password_manager-2024.7.1.xpi";
	      installation_mode = "force_installed";
	    };
	  };
	  ExtensionUpdate = true;
	  OfferToSaveLogins = false;
	};
      };
      git = {
        enable = true;
	extraConfig = {
	  user.name = "Charlie B";
	  user.email = "charlie@charliebatten.co.uk";
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
    };
  };
}
