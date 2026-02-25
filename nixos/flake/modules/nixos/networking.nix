{ userConfig, ... }:

{
  networking = {
    hostName = userConfig.hostname;
    enableIPv6 = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        5900
      ];
    };
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
