{ config, pkgs, lib, ... }:
{
  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    powertop
    ryzenadj
    cpupower
  ];

  services.cpupower.enable = true;
  services.ryzenadj.enable = true;
  services.udex.packages = with pkgs; [ ryzenadj ];
}