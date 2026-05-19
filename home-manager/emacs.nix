{ config, inputs, pkgs, ... }:

let
  # Reusing your out-of-store symlink strategy for immediate live-edits
  dotfileLink = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mysystem/dotfiles/${path}";
in {
  imports = [
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    
    # Points cleanly to a 'doom' folder inside your unmanaged dotfiles repository
    doomDir = dotfileLink "doom"; 

    # Ensures your framework gets the pure Wayland build for a buttery smooth UI
    emacsPackage = pkgs.emacs-pgtk; 
  };
}