{ config, pkgs, inputs, ... }: 

{
  imports = [
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    emacs = pkgs.emacs-pgtk; 

    # Instead of pointing to a locked store directory, we pass the file contents.
    # This allows the builder to reconstruct DOOMDIR with proper execution permissions.
    doomModules = {
      initGnuEl    = builtins.readFile ../dotfiles/doom/init.el;
      configGnuEl  = builtins.readFile ../dotfiles/doom/config.el;
      packagesGnuEl = builtins.readFile ../dotfiles/doom/packages.el;
    };
  };
}