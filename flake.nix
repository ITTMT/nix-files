{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    dolphin-overlay.url = "github:rumboon/dolphin-overlay";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    ... 
  } @ inputs: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  
  in
  {
    nixosConfigurations = {
      ollie = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        inherit system;
        modules = [
          ./flakes/bluetooth.nix
          ./flakes/boot-loader.nix
          ./flakes/configuration.nix
          ./flakes/display-manager.nix
          ./flakes/file-manager.nix
          ./flakes/firewall.nix
          ./flakes/fonts.nix
          ./flakes/gc.nix
          ./flakes/hyprland.nix
          ./flakes/icons.nix
          ./flakes/internationalisation.nix
          # ./flakes/kde.nix
          ./flakes/networking.nix
          ./flakes/nix-settings.nix
          ./flakes/nixpkg.nix
          ./flakes/ocaml.nix
          ./flakes/openscad.nix
          ./flakes/power-management.nix
          ./flakes/rust.nix
          ./flakes/screen.nix
          ./flakes/security.nix
          ./flakes/software.nix
          ./flakes/sound.nix
          ./flakes/users.nix
          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ollie = import ./home-manager/home.nix;
          }
          inputs.stylix.nixosModules.stylix
          inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };
    };
  };
}
