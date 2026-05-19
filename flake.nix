{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    dolphin-overlay.url = "github:rumboon/dolphin-overlay";
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bosl2-src = {
      url = "github:BelfrySCAD/BOSL2";
      flake = false; 
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # This passes our inputs (like stylix, hardware, etc) into all our modules
      specialArgs = { inherit inputs; }; 
      modules = [
        ./hosts/framework/configuration.nix
        ./home/users.nix

        # Toggle Desktops
        ./modules/desktops/kde.nix
        # ./modules/desktops/hyprland.nix

        ./modules/common/fonts.nix
        ./modules/common/gc.nix
        
        # --- ADDED EMACS MODULE HERE ---
        ./modules/common/emacs.nix
        
        ./modules/common/icons.nix
        ./modules/common/internationalisation.nix
        ./modules/common/ocaml.nix
        ./modules/common/openscad.nix
        ./modules/common/rust.nix
        ./modules/common/screen.nix
        ./modules/common/software.nix

        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };

          # --- CLEANEST APPROACH ---
          home-manager.users.ollie = {
            imports = [ ./home-manager/home.nix ];
          };
        }
        inputs.stylix.nixosModules.stylix
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
      ];
    };
  };
}