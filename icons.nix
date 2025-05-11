{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    catppuccin
  ];
  
}