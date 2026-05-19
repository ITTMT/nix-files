{ pkgs, ... }:

{
  # 1. System packages required for Doom Emacs to run and compile code
  environment.systemPackages = with pkgs; [
    # Fixed the package name from emacs29-pgtk to emacs-pgtk
    emacs-pgtk   # Built with native PGTK support for pure Wayland execution under KDE

    # Doom core dependencies
    git
    ripgrep
    fd
    
    # Toolchains needed by Doom to compile native extensions (vterm, treesitter, etc.)
    gnumake
    cmake
    gcc
    binutils
  ];

  # 2. Enable Direnv globally so Emacs can read your Elixir Flakes natively
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Adds standard environment variables to make integration smoother
  environment.sessionVariables = {
    EDITOR = "emacsclient -c -a 'emacs'";
  };
}