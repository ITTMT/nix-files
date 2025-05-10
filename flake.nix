{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    agenix.url = "github:ryantm/agenix";
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
    secretsDir = ./secrets;
  
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

          {
            age.identityPaths = [ "/home/ollie/.ssh/id_ed25519.pub"];
            age.secrets.nm-secrets = {
              file = "${secretsDir}/nm-secret.age";
              owner = "root";
              group = "root";
            };
          }
        ];
      };
    };
  };
}
