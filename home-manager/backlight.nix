{ pkgs, ... }:

let
  backlight-sync = pkgs.writeShellApplication {
    name = "backlight-sync";
    runtimeInputs = [ pkgs.brightnessctl pkgs.coreutils ];
    text = ''
      # Update laptop screen
      brightnessctl -d "amdgpu_bl1" set "$1"

      # Sync external monitor (wildcard handles bus changes)
      PERC=$(brightnessctl -d "amdgpu_bl1" -m | cut -d, -f4 | tr -d '%')
      brightnessctl -d "ddcci*" set "$PERC%"
    '';
  };

  monitor-fix = pkgs.writeShellApplication {
    name = "monitor-fix";
    runtimeInputs = [ pkgs.ddcutil pkgs.coreutils pkgs.gnused pkgs.kmod ];
    text = ''
      echo "Stopping existing ddcci processes..."
      # Force unbind everything to clear the 'Red' links
      for bus in /sys/bus/i2c/devices/i2c-*; do
        if [ -e "$bus/delete_device" ]; then
          echo 0x37 | sudo tee "$bus/delete_device" >/dev/null 2>&1 || true
        fi
      done

      echo "Reloading drivers..."
      sudo modprobe -r ddcci_backlight ddcci 2>/dev/null || true
      sudo modprobe ddcci
      sudo modprobe ddcci_backlight

      echo "Scanning for monitor..."
      BUS=$(ddcutil detect | sed -n '/^Display/,/I2C bus:/p' | grep "I2C bus:" | awk '{print $NF}' | cut -d- -f2 | head -n 1)

      if [ -n "$BUS" ]; then
        echo "Binding to bus $BUS..."
        echo ddcci 0x37 | sudo tee "/sys/bus/i2c/devices/i2c-$BUS/new_device" > /dev/null
        
        echo "Waiting for kernel (3s)..."
        sleep 3
        
        # This checks if the link is still 'broken' (red)
        if [ -L "/sys/class/backlight/ddcci$BUS" ] && [ ! -e "/sys/class/backlight/ddcci$BUS" ]; then
           echo "Error: Device created but symlink is broken. Check 'dmesg | grep ddcci'"
        else
           echo "Success! Device is active."
           ls -l /sys/class/backlight
        fi
      else
        echo "No monitor found."
      fi
    '';
  };
in {
  home.packages = [ backlight-sync monitor-fix ];
}