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

    vulkan-tools         # Useful tools like vulkaninfo and vkcube
    vulkan-headers       # Vulkan API headers (not always needed directly but good to have)
    vulkan-loader        # Vulkan loader (libvulkan.so)
    vulkan-validation-layers # Optional, but very useful for debugging
    spirv-tools           # Tools for working with SPIR-V shaders
    shaderc               # Compiler for GLSL to SPIR-V
    libxkbcommon  # Required for many Wayland clients
    wayland
    wayland-protocols
    wlroots        # Optional, if using wlroots-based compositor like Hyprland/Sway
  ];

  hardware.opengl = {
    enable = true;  # enables OpenGL/Vulkan support system-wide
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