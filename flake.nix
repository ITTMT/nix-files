{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { 
    self, 
    nixpkgs, 
    ... 
  }: 
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
        inherit system;
        modules = [
          ./boot-loader.nix
          ./configuration.nix
          ./display-manager.nix
          ./firewall.nix
          ./fonts.nix
          ./hyprland.nix
          ./internationalisation.nix
          # ./kde.nix
          ./networking.nix
          ./nix-settings.nix
          ./nixpkg.nix
          ./screen.nix
          ./security.nix
          ./software.nix
          ./sound.nix
          ./users.nix
        ];
      };
    };
  };
}
