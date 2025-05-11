{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    catppuccin
    nerd-fonts
    noto-fonts-emoji  # for proper emoji rendering
    noto-fonts-cjk-sans # for better unicode support
  ];
}