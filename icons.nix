{ pkgs, catppuccin, ... }:
{
  environment.systemPackages = with pkgs; [
    catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}