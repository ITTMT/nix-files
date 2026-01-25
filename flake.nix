{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    dolphin-overlay.url = "github:rumboon/dolphin-overlay";
  };

  outputs = { 
    self, 
    nixpkgs, 
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
      myNixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        inherit system;
        modules = [
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
          ./users.nix

          inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };
    };
  };
}
