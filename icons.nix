{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    catppuccin
    nerd-fonts
    noto-fonts-emoji  # for proper emoji rendering
    noto-fonts-cjk    # for better unicode support
  ];
}