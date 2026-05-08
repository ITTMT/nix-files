{ config, pkgs, lib, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 10;
  boot.initrd.enable = true;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "i915" ];
  boot.initrd.kernelModules          = [ "i915" ];
  boot.consoleLogLevel = 3;
  boot.plymouth = {
    enable = true;
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    themePackages = [ pkgs.catppuccin-plymouth ];
    theme = "catppuccin-macchiato";
  };
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;

  # Enable Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet \
          --time --time-format '%I:%M %p | %a • %h | %F' \
          --cmd 'uwsm start hyprland'";
        user    = "greeter";
      };
    };
  };

  users.users.greeter = {
    isNormalUser = false;
    description  = "greetd greeter user";
    extraGroups  = [ "video" "audio" ];
    linger        = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.wirelessRegulatoryDatabase = true;

  powerManagement.powertop.enable = true;

  services.udev.packages = with pkgs; [ ryzenadj ];

  environment.systemPackages = with pkgs; [
    kitty
    waybar        # A status bar for Wayland
    wofi          # A launcher (similar to rofi, but for Wayland)
    mako          # A notification daemon for Wayland
    wl-clipboard  # Clipboard utilities for Wayland
    grim          # Screenshot tool for Wayland
    slurp         # Region selector for screenshots
    xdg-desktop-portal-hyprland # For Wayland desktop portals
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    nautilus
    eww
    pamixer
    pavucontrol
    tuigreet
    kdePackages.dolphin
    kdePackages.qt6ct        # The configuration tool for Qt6
    networkmanagerapplet
    bluez
    blueman
    speedtest-cli
    wavemon
    powertop
    ryzenadj
    linuxKernel.packages.linux_zen.cpupower
  ];
}