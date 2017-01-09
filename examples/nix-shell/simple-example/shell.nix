{ pkgs ? import <nixpkgs> {} }:

with pkgs;
stdenv.mkDerivation {
  name = "simple";

  buildInputs = [ git
                  vim
                  netcdf
                ];

  shellHook = ''
    echo "Welcome to your new shell";
    export PS1="\n\[\033[1;32m\][${name}-shell:\w]$\[\033[0m\] "
  '';
}