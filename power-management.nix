{ config, pkgs, lib, ... }:
{
  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    powertop
  ];
}