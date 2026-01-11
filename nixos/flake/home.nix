{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/home-manager/hyprland.nix
    ./modules/home-manager/waybar.nix
    ./modules/home-manager/shell.nix
    ./modules/home-manager/git.nix
    ./modules/home-manager/theme.nix
    ./modules/home-manager/packages.nix
  ];

  home = {
    username = "charlie";
    homeDirectory = "/home/charlie";
    stateVersion = "24.05";
  };
}
