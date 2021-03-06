
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
           import <nixpkgs> {};
  my_pythonPackages = rec {
    pint = pkgs.pythonPackages.buildPythonPackage rec {
      name = "Pint-${version}";
      version = "0.7.2";
      src = pkgs.fetchurl {
        url = "mirror://pypi/p/pint/${name}.tar.gz";
        sha256 = "38b97d352a6376bb4e957095c8b75c1c2aa8edbf9a7ccf058d69b147862e77ad";
      };
    };
  };
in with pkgs; stdenv.mkDerivation rec {
  name = "some-python-project";
  src = if lib.inNixShell then null else ./.; # Avoid copying of src dir when using nix-shell
  buildInputs = [ stdenv
                  pythonPackages.numpy
                  pythonPackages.pandas
                  my_pythonPackages.pint
  ];

}

