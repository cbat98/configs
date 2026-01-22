{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    alsa-utils
    antigravity
    brightnessctl
    fastfetch
    fastmod
    fd
    feh
    gccgo
    gnome-icon-theme
    google-chrome
    inputs.hyprlauncher.packages.${pkgs.stdenv.hostPlatform.system}.hyprlauncher
    inter
    jq
    magic-wormhole
    nautilus
    neovim
    nerd-fonts.caskaydia-cove
    nettools
    pamixer
    pavucontrol
    qbittorrent
    ripgrep
    tldr
    unzip
    vlc
    wl-clipboard
    zip
  ];
}
