{ config, pkgs, lib, ... }:
{
 environment.systemPackages = with pkgs; [
    git
    gh
    vscode
    discord
    age
    firefox
    gamescope
    spotify
    jetbrains.rider
    keepassxc
    obsidian
    unzip
    hyprshot
    libnotify
    direnv
    xmousepasteblock
    freecad
    btop
    htop
    fzf
    jq
    rocmPackages.rocm-smi
    gcc           # Required for Treesitter to compile parsers
    ripgrep       # Required for Telescope
    fd            # Required for Telescope
    lua-language-server
    stylua        # Lua formatter
  ];

  services.dbus.enable = true;
  
  virtualisation.docker.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL support
    ];
  };

  environment.variables = {
    HSA_OVERRIDE_GFX_VERSION = "11.0.2";
  };

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