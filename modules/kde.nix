{ config, pkgs, lib, ... }:
{

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable KDE Plasma
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  # Set the default session to KDE Plasma
  services.xserver.displayManager.defaultSession = "plasma6";

  # Enable the KDE Connect service
  services.kdeconnect.enable = true;

  # Enable the clipboard manager
  services.clipboard.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ollie";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}