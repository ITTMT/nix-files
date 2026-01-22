{ config, pkgs, lib, ... }:
{
 environment.systemPackages = with pkgs; [
    git
    gh
    vscode
    discord
    stow
    age
    firefox
    gamescope
    spotify
    jetbrains.rider
    keepassxc
    obsidian
  ];

  services.dbus.enable = true;
  
  virtualisation.docker.enable = true;

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = ["amdgpu"];


  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}