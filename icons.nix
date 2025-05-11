{ pkgs, catppuccin, ... }:
{
  catppuccin.nixosModules.catppuccin


  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}