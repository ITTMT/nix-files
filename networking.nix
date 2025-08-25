{ pkgs, ... }:

{
  networking.hostName = "nixos"; # Define your hostname.
  networking.useNetworkd = true;
  networking.wireless.iwd.enable = true;
}