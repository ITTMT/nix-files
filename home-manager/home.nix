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
  xdg.configFile."waybar".source = ../dotfiles/waybar;

  # Enable programs with managed configs
  programs.git = {
    enable = true;
    userName = "ITTMT";
    userEmail = "oliver.iasmith@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      
      # Credential helpers for GitHub
      "credential \"https://github.com\"" = {
        helper = [
          ""
          "!${pkgs.gh}/bin/gh auth git-credential"
        ];
      };
      "credential \"https://gist.github.com\"" = {
        helper = [
          ""
          "!${pkgs.gh}/bin/gh auth git-credential"
        ];
      };
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}