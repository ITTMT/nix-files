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

  environment.variables = {
    SSH_AUTH_SOCK = "${config.services.gnome.gnome-keyring.socketDir}/ssh";
    GPG_AGENT_INFO = "${config.services.gnome.gnome-keyring.socketDir}/gpg";
  };
}
