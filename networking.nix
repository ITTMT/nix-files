{ pkgs, ... }:

{
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  hardware.wirelessRegulatoryDatabase = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    bluez
    blueman
  ];
}