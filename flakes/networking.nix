{ pkgs, ... }:

{
  networking.hostName = "nixos";

  # Permanent Fixes for MediaTek MT7925 + Vodafone Fiber
  networking.interfaces.wlp192s0.mtu = 1492;

  networking.wireless.iwd.settings = {
    Settings = {
      AutoConnect = true;
    };
  };
  
  # 1. NetworkManager with iwd (still recommended for MediaTek)
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    wifi.powersave = false; 
  };

  # 2. Regulatory Domain (Essential for WiFi 7/6E)
  hardware.wirelessRegulatoryDatabase = true;
  networking.wireless.extraConfig = "country=GB";

  # 3. MediaTek Specific Fixes (The "Secret Sauce")
  # We disable PCIe power management for this specific card to stop the 'downshifting'
  # boot.kernelParams = [ 
  #   # Force the card to stay in High Performance mode
  #   "mt76.disable_usb_sg=1" 
  #   "pcie_aspm=off" 
  #   "mt7921e.disable_aspm=1"
  # ];

  # 4. Ensure you have the absolute latest firmware
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    gnome-control-center
    networkmanager_dmenu
    networkmanagerapplet
    iw
    speedtest-cli
    wavemon
  ];

  # Keep your dconf/dark mode settings here too
  programs.dconf.enable = true;
}