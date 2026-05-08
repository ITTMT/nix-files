{ config, pkgs, lib, ... }:

{
  # Enable the KDE Plasma Desktop Environment
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Ensures SDDM and Plasma use Wayland for Ryzen efficiency
  };
  services.desktopManager.plasma6.enable = true;

  # Enable automatic login for the user
  services.displayManager.autoLogin = {
    enable = true;
    user = "ollie";
  };

  # Configure keymap
  # Note: Plasma 6 usually manages this via its own UI, but setting it here 
  # ensures the login screen (SDDM) uses the correct layout.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Tiling and Utilities
  environment.systemPackages = with pkgs; [
    kdePackages.polonium     # This provides the Hyprland-style tiling
    kdePackages.spectacle    # Better screenshots
    kdePackages.kate         # Useful GUI editor for quick tweaks
    wl-clipboard            # System-wide clipboard support for Wayland
  ];

  # Efficiency & Clean-up
  # Removing legacy X11 startx lines as Plasma 6 defaults to Wayland
  # and startx is generally not recommended for modern Wayland sessions.
}