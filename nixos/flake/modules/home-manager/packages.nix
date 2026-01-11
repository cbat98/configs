{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    alsa-utils
    antigravity
    brightnessctl
    fastfetch
    fd
    feh
    gccgo
    gnome-icon-theme
    google-chrome
    jq
    nautilus
    neovim
    nettools
    oh-my-posh
    pamixer
    pavucontrol
    qbittorrent
    ripgrep
    tldr
    unzip
    vlc
    wl-clipboard
    zip
    inputs.hyprlauncher.packages.${pkgs.stdenv.hostPlatform.system}.hyprlauncher
  ];
}
