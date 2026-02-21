{ pkgs, ... }: {
  home.username = "ollie";
  home.homeDirectory = "/home/ollie";
  home.stateVersion = "25.11"; # Check the HM manual for the latest version

  # Install packages for the user
  home.packages = with pkgs; [
    htop
    fzf
  ];

  # This is where your "Stow" logic lives
  home.file.".config/alias-file".text = "alias gs='git status'";

  # Enable programs with managed configs
  programs.git = {
    enable = true;
    settings.user.name = "ITTMT";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}