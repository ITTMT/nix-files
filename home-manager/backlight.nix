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
in {
  home.packages = [ backlight-sync ];
}