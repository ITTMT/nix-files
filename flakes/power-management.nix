{ config, pkgs, lib, ... }:
{
  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    powertop
    ryzenadj
    linuxKernel.packages.linux_zen.cpupower
  ];

  services.udev.packages = with pkgs; [ ryzenadj ];
}