{ pkgs, config, ... }:

let
  bind-ddcci = pkgs.writeShellScript "bind-ddcci" ''
    # Write to a file we can definitely see, just in case journald is acting up
    echo "Script executed at $(date)" >> /tmp/ddcci_debug.log

    # Log to journal
    echo "DDC/CI trigger fired" | systemd-cat -t bind-ddcci

    sleep 5

    # Cleanup ghosts
    for bus in /sys/bus/i2c/devices/i2c-*; do
      if [ -e "$bus/delete_device" ]; then
        echo 0x37 > "$bus/delete_device" 2>/dev/null || true
      fi
    done

    # Bind new
    for i in /sys/class/i2c-dev/i2c-*/device/new_device; do
      echo ddcci 0x37 > "$i" 2>/dev/null || true
    done
  '';
in
# ... rest of your screen.nix remains the same
{
  # I2C support
  hardware.i2c.enable = true;

  users.users.ollie.extraGroups = [ "i2c" "video" ];

  environment.systemPackages = with pkgs; [
    wlsunset
    ddcutil
    brightnessctl
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ 
    ryzen-smu
    ddcci-driver 
  ];

  boot.kernelModules = [ "i2c-dev" "ddcci_backlight" "ryzen_smu" ];

  services.udev.extraRules = ''
    # 1. Grant permissions to the I2C buses themselves
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"

    # 2. When a ddcci backlight device is added, give the video group control
    # This fixes the 'Red' broken link/permission issue
    SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="ddcci*", RUN+="${pkgs.bash}/bin/sh -c 'chgrp video /sys/class/backlight/%k/brightness && chmod g+w /sys/class/backlight/%k/brightness'"
  '';
}