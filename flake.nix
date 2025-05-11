{
  description = "A very basic flake";

  inputs = {
    catppuccin.url = "github:catppuccin/nix";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { 
    self, 
    nixpkgs, 
    catppuccin,
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
          catppuccin.nixosModules.catppuccin

          ./boot-loader.nix
          ./configuration.nix
          ./display-manager.nix
          ./firewall.nix
          ./fonts.nix
          ./hyprland.nix
          ./icons.nix
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
