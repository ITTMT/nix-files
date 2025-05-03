{ config, pkgs, lib, ... }:
{
 environment.systemPackages = with pkgs; [
    git
    gh
    vscode
    discord
    stow
  ];
}