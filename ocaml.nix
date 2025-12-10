{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ocaml
    ocamlPackages.dune
    ocamlPackages.findlib
    ocamlPackages.merlin
    ocamlPackages.ocaml-lsp
  ];
}