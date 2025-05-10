{ config, pkgs, lib, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    waybar        # A status bar for Wayland
    wofi          # A launcher (similar to rofi, but for Wayland)
    mako          # A notification daemon for Wayland
    wl-clipboard  # Clipboard utilities for Wayland
    grim          # Screenshot tool for Wayland
    slurp         # Region selector for screenshots
    xdg-desktop-portal-hyprland # For Wayland desktop portals
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    nautilus
  ];
}