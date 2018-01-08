{ pkgs ? import <nixpkgs> {} }:
with pkgs;
stdenv.mkDerivation rec {
  name = "my-R-project";
  src = if lib.inNixShell then null else ./.;
  buildInputs = with rPackages; [
    R
    devtools
    ggplot2
    knitr
    optparse
    reshape2
    yaml
  ];
}
