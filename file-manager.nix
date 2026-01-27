{ config, pkgs, lib, inputs, ... }:

{
 environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.dolphin-plugins # For git integration/right-click features
    kdePackages.kdegraphics-thumbnailers # For image thumbnails
    kdePackages.ffmpegthumbs # For video thumbnails
    kdePackages.ark # For "Extract here" context menu support
    libsForQt5.qt5ct # Optional: helps with theming if you have Qt5 apps
    kdePackages.qt6ct # Newer version for Qt6 apps like Dolphin
  ];

  # 3. Fix "Open With" and missing menu issues
  # This links the KDE application menu so Dolphin knows what apps are installed
  environment.etc."xdg/menus/applications.menu".source = 
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # 4. Ensure Portals are set up for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.common.default = [ "gtk" ]; # Fallback
    config.hyprland.default = [ "hyprland" "kde" ];
  };
}
