{ config, pkgs, lib, inputs, ... }:

{
 environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qt6ct        # The configuration tool for Qt6
    kdePackages.qtstyleplugin-kvantum # The engine that draws the dark theme
    libsForQt5.qt5ct         # For older Qt5 apps
  ];

  environment.sessionVariables = {
    # Tells Qt apps to look at qt6ct for their instructions
    QT_QPA_PLATFORMTHEME = "qt6ct";
    # Force them to use Kvantum (which Stylix themes automatically)
    QT_STYLE_OVERRIDE = "kvantum";
    GTK_USE_PORTAL = "1";
  };

  # 3. Fix "Open With" and missing menu issues
  # This links the KDE application menu so Dolphin knows what apps are installed
# pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # 4. Ensure Portals are set up for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.kdePackages.xdg-desktop-portal-kde 
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = [ "gtk" ];
    config.hyprland.default = [ "hyprland" "kde" ];
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "org.kde.dolphin.desktop";
    "application/x-gnome-saved-search" = "org.kde.dolphin.desktop";
  };
}
