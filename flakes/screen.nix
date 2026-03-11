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
}