{ pkgs, ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.wirelessRegulatoryDatabase = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    bluez
    blueman
  ];
}