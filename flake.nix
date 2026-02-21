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
    }
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
          ./bluetooth.nix
          ./boot-loader.nix
          ./configuration.nix
          ./display-manager.nix
          ./file-manager.nix
          ./firewall.nix
          ./fonts.nix
          ./hyprland.nix
          ./icons.nix
          ./internationalisation.nix
          # ./kde.nix
          ./networking.nix
          ./nix-settings.nix
          ./nixpkg.nix
          ./ocaml.nix
          ./power-management.nix
          ./rust.nix
          ./screen.nix
          ./security.nix
          ./software.nix
          ./sound.nix
          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ollie = import ./home.nix;
          }
          ./users.nix
          inputs.stylix.nixosModules.stylix
          inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };
    };
  };
}
