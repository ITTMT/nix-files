{ config, pkgs, ... }:

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # --- BOOTLOADER FIX ---
  # These lines resolve the "Failed assertions" error regarding GRUB.
  # We use systemd-boot as it is the standard for modern UEFI Framework laptops.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10; # Keeps your boot menu clean

  # --- SYSTEM SETTINGS ---
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/London";

  # This value determines the NixOS release for stateful data.
  # Keep this as "25.05" even if you upgrade versions later.
  system.stateVersion = "25.05"; 

  # --- HARDWARE & EFFICIENCY ---
  # AMD P-State is vital for Ryzen AI 300 efficiency
  boot.kernelParams = [ 
    "amd_pstate=active" 
    "btusb.enable_autosuspend=0" # Prevents Bluetooth from dropping out to save power
  ];

  # Framework specific services
  services.fwupd.enable = true;      # Firmware updates
  services.thermald.enable = true;   # Prevents overheating
  services.power-profiles-daemon.enable = true; # KDE/GNOME power slider support
  
  # LPDDR5 Efficiency: zramSwap helps manage that 128GB of RAM efficiently
  zramSwap.enable = true;

  # Lid behavior (important for Framework laptops used with docks)
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  networking.networkmanager.enable = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Ensures it's on when you start up
    settings = {
      General = {
        Experimental = true; # Shows battery levels of connected devices in KDE
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # --- INPUT & PERIPHERALS ---
  # Printing
  services.printing.enable = true;

  # Fingerprint sensor configuration for Framework 13
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
  };
}