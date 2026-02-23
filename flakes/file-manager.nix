{ config, pkgs, lib, inputs, ... }:

{
 environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qt6ct        # The configuration tool for Qt6
  ];
}
