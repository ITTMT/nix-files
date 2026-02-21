{ pkgs, ... }: {
  home.username = "ollie";
  home.homeDirectory = "/home/ollie";
  home.stateVersion = "25.11"; # Check the HM manual for the latest version

  # Install packages for the user
  home.packages = with pkgs; [
    htop
    fzf
  ];

  xdg.configFile."hypr".source = ../dotfiles/hypr;
  # xdg.configFile."waybar".source = ../dotfiles/waybar;

  # Enable programs with managed configs
  programs.git = {
    enable = true;
    settings.user.name = "ITTMT";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}