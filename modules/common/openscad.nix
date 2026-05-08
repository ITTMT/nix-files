{ config, pkgs, inputs, ... }:

let
  # 1. The original package
  orca = pkgs.orca-slicer;

  # 2. The scaling script
  orca-scaled-bin = pkgs.writeShellScriptBin "orca-slicer" ''
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    exec ${orca}/bin/orca-slicer "$@"
  '';


  # 4. Join them all together
  scaled-orca = pkgs.symlinkJoin {
    name = "orca-slicer";
    paths = [ orca-scaled-bin orca ];
  };
in
{
  services.octoprint.enable = true;

  environment.systemPackages = [ 
    pkgs.openscad-unstable
    pkgs.printrun
    scaled-orca
  ];

  # This sets the global environment variable so OpenSCAD knows where to look
  environment.variables.OPENSCADPATH = [
    "${inputs.bosl2-src}"
  ];

  # Optional: If you want it to show up in your home folder for easy browsing
  home-manager.users.ollie = {
    home.file.".local/share/OpenSCAD/libraries/BOSL2".source = inputs.bosl2-src;
  };
}