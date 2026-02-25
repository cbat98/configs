{ ... }:

{
  services.displayManager.defaultSession = "hyprland";

  programs = {
    wayvnc.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    steam.enable = true;
  };
}
