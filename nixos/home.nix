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
