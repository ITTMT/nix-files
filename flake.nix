{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    secrets.url = "path:./secrets"
  };

  outputs = { 
    self, 
    nixpkgs, 
    agenix, 
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
          ({ config, ... }: { nixpkgs.config.allowUnfree = true; })
          agenix.nixosModules.default
          ./nixos/configuration.nix
          ./modules/software.nix
          # ./modules/kde.nix
          ./modules/hyprland.nix
        ];
      };
    };
  };
}
