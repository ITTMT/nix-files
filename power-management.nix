{ config, pkgs, lib, ... }:
{
  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    powertop
    ryzenadj
    cpupower
  ];
  services.udev.packages = with pkgs; [ ryzenadj ];
}