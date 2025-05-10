{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-keyring
    seahorse # Optional, a GUI for managing secrets
    libsecret
  ];

  # Make sure the keyring daemon is started on login
  services.gnome.gnome-keyring = {
    enable = true;
  };

  systemd.user.services.gnome-keyring-daemon = {
    enable = true;
    wantedBy = [ "default.target" ];
  };
}
