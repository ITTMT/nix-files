{ pkgs, ... }:

{
  # 1. System packages required for Doom Emacs toolchains to operate
  environment.systemPackages = with pkgs; [
    # Doom core dependencies for finding files and project tracking
    git
    ripgrep
    fd
    
    # Toolchains needed by Doom to compile native source extensions (vterm, treesitter parsers)
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