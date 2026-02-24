{ ... }:

{
  services.displayManager.defaultSession = "hyprland";

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    steam.enable = true;
  };
}
