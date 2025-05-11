{ pkgs, catppuccin, ... }:
{
  catppuccin.nixosModules.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}