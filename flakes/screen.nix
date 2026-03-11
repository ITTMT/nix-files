{ pkgs, config, ... }:

{
  programs.light.enable = true;

  # I2C support
  hardware.i2c.enable = true;

  users.users.ollie.extraGroups =  [ "i2c" ];

  environment.systemPackages = with pkgs; [
    wlsunset
    ddcutil
    brightnessctl
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
  boot.kernelModules = [ "i2c-dev" "ddcci-backlight" ];

  services.udev.extraRules = ''
    SUBSYSTEM=="i2c-dev", ACTION=="add", ATTR{name}=="*DDR*", ATTR{name}=="*ddc*", RUN+="${pkgs.kmod}/bin/modprobe ddcci_backlight", RUN+="${pkgs.bash}/bin/sh -c 'echo ddcci 0x37 > /sys/class/i2c-dev/%k/device/new_device'"
  '';
}