{ pkgs, ... }:

{
  networking.wireless.iwd.enable = true;
  networking.useNetworkd = false;
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = true;
      RoamThreshold = -80;      # Only roam if signal is worse than -80dBm
      AutoConnect = true;
    };
    Network = {
      EnableIPv6 = true;
      EnableIPv4 = true;
    };
  };
}