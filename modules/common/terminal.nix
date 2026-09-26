{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminals
    ghostty
    kitty
    wezterm

    # CLI Enhancements
    eza # Better ls
    bat # Better cat
    fzf # Fuzzy finder
    btop # Resource monitor
  ];

  # These tools require shell integration to work properly
  programs = {
    starship.enable = true;
    zoxide.enable = true;
    direnv.enable = true;
  };
}
