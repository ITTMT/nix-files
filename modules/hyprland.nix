{ config, pkgs, lib, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
  };

  services.displayManager.sddm.enable = false;
  services.displayManager.sddm.wayland.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    waybar        # A status bar for Wayland
    wofi          # A launcher (similar to rofi, but for Wayland)
    mako          # A notification daemon for Wayland
    wl-clipboard  # Clipboard utilities for Wayland
    grim          # Screenshot tool for Wayland
    slurp         # Region selector for screenshots
    xdg-desktop-portal-hyprland # For Wayland desktop portals
  ];
}