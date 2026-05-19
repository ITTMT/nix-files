{ pkgs, ... }:

{
  # 1. System packages required for Doom Emacs to run and compile code
  environment.systemPackages = with pkgs; [
    # The Emacs binary itself (compiled with native compilation and tree-sitter support)
    emacs29-pgtk   # Use emacs-gtk if you are on standard X11, pgtk is perfect for Wayland/KDE

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

  # Optional: Adds standard environment variables to make integration smoother
  environment.sessionVariables = {
    EDITOR = "emacsclient -c -a 'emacs'";
  };
}