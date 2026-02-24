{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    alsa-utils
    antigravity
    brightnessctl
    fastfetch
    fastmod
    fd
    feh
    gnome-icon-theme
    google-chrome
    hyprlauncher
    inter
    jq
    libgcc
    magic-wormhole
    nautilus
    neovim
    nerd-fonts.caskaydia-cove
    nettools
    orca-slicer
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
