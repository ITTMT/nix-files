{ config, pkgs, inputs, ... }: # Added inputs here
let 
  dotfileLink = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mysystem/dotfiles/${path}";
in {
  imports = [ 
    ./backlight.nix
    ./emacs.nix
  ];



  home.username = "ollie";
  home.homeDirectory = "/home/ollie";
  home.stateVersion = "25.11"; # Check the HM manual for the latest version

  # Install packages for the user
  home.packages = with pkgs; [
    
  ];

  home.sessionVariables = {
    EDITOR = "code";
  };

  home.language = {
    base = "en_GB.UTF-8";
    address = "en_GB.UTF-8";
    monetary = "en_GB.UTF-8";
    paper = "en_GB.UTF-8";
    time = "en_GB.UTF-8";
  };

  xdg.configFile."hypr".source = dotfileLink "hypr";
  xdg.configFile."waybar".source = dotfileLink "waybar";
  xdg.configFile."nvim".source = dotfileLink "nvim";

  programs.bash = {
    enable = true;
    package = pkgs.bashInteractive; # Ensures readline and programmable completion are enabled
    
    # This replaces your aliases
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/mysystem";
      v = "nvim";
      e = "emacsclient -c -a ''"; # Opens a graphical frame. If daemon is dead, starts it.
      et = "emacsclient -t -a ''"; # Opens directly inside your terminal window.
      vs-server = "vintagestory-server --dataPath ~/vintagestory-server/data";
    };

    # Everything from your old .bashrc goes here
    bashrcExtra = ''
      # Update these to use #framework
      alias rebuild="sudo nixos-rebuild switch --flake ~/mysystem#framework" 
      alias upgrade="cd ~/mysystem && nix flake update && git add . && sudo nixos-rebuild switch --flake .#framework"
      
      alias cleanup="sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-collect-garbage -d"
      alias generations="sudo nix-env -p /nix/var/nix/profiles/system --list-generations"
      
      eval "$(direnv hook bash)"
    '';

    # Everything from your old .bash_profile goes here
    # (Environment variables that should only be set once at login)
    profileExtra = ''
      # Example: gpg setup or session-wide variables
    '';
  };

  # Enable programs with managed configs
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ITTMT";
        email = "oliver.iasmith@gmail.com";
      };
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

  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
