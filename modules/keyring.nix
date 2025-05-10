{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-keyring
    seahorse # Optional, a GUI for managing secrets
  ];

  # Make sure the keyring daemon is started on login
  services.gnome.gnome-keyring = {
    enable = true;
  };
}
