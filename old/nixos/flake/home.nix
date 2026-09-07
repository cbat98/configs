{ userConfig, ... }:

{
  imports = [
    ./modules/home-manager/hyprland.nix
    ./modules/home-manager/waybar.nix
    ./modules/home-manager/shell.nix
    ./modules/home-manager/git.nix
    ./modules/home-manager/packages.nix
  ];

  home = {
    username = userConfig.username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = "24.05";
  };
}
