{ config, pkgs, inputs, ... }:

let 
  dotfileLink = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mysystem/dotfiles/${path}";
in {
  imports = [ 
    ./backlight.nix
    ./emacs.nix
  ];

  home.username = "ollie";
  home.homeDirectory = "/home/ollie";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [ ];

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
    package = pkgs.bashInteractive;
    
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/mysystem";
      v = "nvim";
      e = "emacsclient -c -a ''";
      et = "emacsclient -t -a ''";
      vs-server = "vintagestory-server --dataPath ~/vintagestory-server/data";
    };

    bashrcExtra = ''
      # Update these to use #framework
      alias rebuild="sudo nixos-rebuild switch --flake ~/mysystem#framework" 
      alias upgrade="cd ~/mysystem && nix flake update && git add . && sudo nixos-rebuild switch --flake .#framework"
      
      alias cleanup="sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-collect-garbage -d"
      alias generations="sudo nix-env -p /nix/var/nix/profiles/system --list-generations"
    '';

    profileExtra = ''
      # Session-wide environment variables
    '';
  };

  # Native direnv + nix-direnv integration
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ITTMT";
        email = "oliver.iasmith@gmail.com";
      };
      init.defaultBranch = "main";
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

  programs.home-manager.enable = true;
}