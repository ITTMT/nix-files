{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ocaml
    # ocamlPackages.dune_2
    # ocamlPackages.findlib
    # ocamlPackages.merlin
    # ocamlPackages.ocaml-lsp
  ];
}