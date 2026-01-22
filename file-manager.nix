{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.qtsvg
    kdePackages.dolphin
  ];
  
}