{nixpkgs ? null}:
let
  pinnedPkg = (import <nixpkgs> {}).fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "8ef3eaeb4e531929ec29a880cb4c67f790e5eb70";
    sha256 = "1v9lgk3j394i91qz1h7cv6mbg6xkdllfccc902ydb1gvp6bzmh6z";
  };
  pkgs = if nixpkgs==null then
           import pinnedPkg {}
         else
           import nixpkgs {};
in with pkgs; stdenv.mkDerivation rec {
  name = "bebenmeldung";
  src = ./.;
  buildInputs = [ stdenv
                  php70Packages.composer
  ];
}
