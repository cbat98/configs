{ pkgs, inputs, userConfig, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/nixos/boot.nix
    ./modules/nixos/desktop.nix
    ./modules/nixos/hardware.nix
    ./modules/nixos/locale.nix
    ./modules/nixos/networking.nix
    ./modules/nixos/nix.nix
    ./modules/nixos/services.nix
    ./modules/nixos/users.nix
    ./modules/nixos/virtualisation.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs userConfig; };
    users.${userConfig.username} = import ./home.nix;
  };

  environment.systemPackages = with pkgs; [
    linux-firmware
    vim
  ];

  # This value defines the first version of NixOS installed on this machine.
  # Do NOT change it — see `man configuration.nix` for details.
  system.stateVersion = "25.05";
}
