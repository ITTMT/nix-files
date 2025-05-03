{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
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

          ./nixos/configuration.nix
          ./modules/software.nix
          ./modules/kde.nix
        ];
      };
    };
  };
}
