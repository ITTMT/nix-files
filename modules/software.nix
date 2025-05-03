{ config, pkgs, lib, ... }:
{
 nixpkgs.config.allowUnfree = true; 

 environment.systemPackages = with pkgs; [
    git
    gh
    vscode
    discord
    stow
  ];
}