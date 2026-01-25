{ config, pkgs, lib, inputs, ... }:

{
  # nixpkgs.overlays = [ inputs.dolphin-overlay.overlays.default ];

  # environment.sessionVariables = {
  #   XDG_CURRENT_DESKTOP = "Hyprland";
  #   XDG_SESSION_DESKTOP = "Hyprland";
  #   MOZ_ENABLE_WAYLAND = "1";
  # };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
  #   config.common.default = "kde";
  # };

  # xdg.mime = {
  #   enable = true;
  #   defaultApplications = {
  #     "inode/directory" = [ "org.kde.dolphin.desktop" ];
  #   };
  # };

  # environment.systemPackages = with pkgs; [
  #   kdePackages.xdg-desktop-portal-kde
  #   kdePackages.qtsvg
  #   kdePackages.dolphin
  # ];
}
