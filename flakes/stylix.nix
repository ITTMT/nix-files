{ pkgs, ... }: {
  stylix = {
    enable = true;
    image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    
    # This ensures Dolphin and other Qt apps follow the dark theme
    targets.qt.enable = true;
    targets.gtk.enable = true;
    targets.qt.platform = "qtct"; # This links Stylix to qt6ct automatically

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # This helps fonts look consistent in Dolphin/Qt apps
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
    };
  };
}