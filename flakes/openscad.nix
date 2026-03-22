{
  description = "OpenSCAD project with BOSL2";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    bosl2-src = {
      url = "github:BelfrySCAD/BOSL2";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, bosl2-src }:
    let
      system = "x86_64-linux"; # adjust to "aarch64-linux" if on ARM
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.openscad-unstable ];
        
        shellHook = ''
          # Create a temporary directory for libraries and symlink BOSL2
          export OPENSCADPATH="$PWD/.nix-libraries"
          mkdir -p "$OPENSCADPATH"
          ln -sfn "${bosl2-src}" "$OPENSCADPATH/BOSL2"
          echo "BOSL2 wired up. You can now use: include <BOSL2/std.scad>"
        '';
      };
    };
}