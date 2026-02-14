{ pkgs, ... }: {
  stylix = {
    enable = true;
    # image = ./path/to/your/wallpaper.jpg; # Stylix requires a base image to generate colors
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    
    # This ensures Dolphin and other Qt apps follow the dark theme
    targets.qt.enable = true;
    targets.gtk.enable = true;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };
}