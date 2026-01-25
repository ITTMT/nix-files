{ pkgs, ... }:

{
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  hardware.wirelessRegulatoryDatabase = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    bluez
    blueman
  ];
}