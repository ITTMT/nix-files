{ config, pkgs, inputs, ... }: 

{
  imports = [
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    emacs = pkgs.emacs-pgtk; 

    # 1. Point directly to your repository folder. Nix will read the content.
    doomDir = ../dotfiles/doom; 

    # 2. Tell Doom to put its build artifacts, caches, and state files here 
    # instead of crashing against the immutable Nix store.
    doomLocalDir = "${config.home.homeDirectory}/.local/share/nix-doom";
  };

  services.emacs = {
    enable = true;
  };
}