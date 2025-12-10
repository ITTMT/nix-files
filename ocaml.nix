{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ocaml
    ocamlPackages.findlib
    dune_2
    ocamlPackages.ocaml-lsp
    opam
  ];
}