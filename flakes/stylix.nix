{ pkgs, ... }: {
  stylix = {
    enable = true;
    image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    polarity = "dark";
    base16Scheme = {
      base00 = "f2e4bc"; # Default Background (Aged Parchment)
      base01 = "e6d5ac"; # Lighter Background (Gutter/Status)
      base02 = "d9c69c"; # Selection Background
      base03 = "8f7f5f"; # Comments, Invisibles, Line Highlighting
      base04 = "4a4133"; # Dark Foreground (Used for status bars)
      base05 = "2b251d"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "1a1611"; # Light Foreground (Not often used)
      base07 = "000000"; # Light Background (Not often used)
      base08 = "b32020"; # Variables, XML Tags, Markup Link Text, Markup Lists
      base09 = "9c4a10"; # Integers, Boolean, Constants, XML Attributes
      base0A = "826300"; # Classes, Markup Bold, Search Text Background
      base0B = "3e662d"; # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "1a6b6b"; # Support, Regular Expressions, Escape Characters
      base0D = "1a4d8c"; # Functions, Methods, Attribute IDs, Headings
      base0E = "6b2a8c"; # Keywords, Storage, Selector, Markup Italic
      base0F = "8c3a1a"; # Deprecated, Opening/Closing Embedded Language Tags
    };
}