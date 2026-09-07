{ ... }:

{
  hardware = {
    nvidia.open = true;
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
