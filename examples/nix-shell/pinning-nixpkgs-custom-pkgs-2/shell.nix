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
  not_yet_in_nixpkgs = rec {
    aniso8601 = pkgs.python35Packages.buildPythonPackage rec {
      name = "aniso8601-${version}";
      version = "1.2.0";
      src = pkgs.fetchFromBitbucket {
        owner = "nielsenb";
        repo = "aniso8601";
        rev = "v${version}";
        sha256 = "0jrlix76h09vxsayphlvzs3ach2bm526i66h3zaqh3m4sflzxj2w";
      };
      propagatedBuildInputs = with pkgs; [
        python35Packages.dateutil
      ];
    };

    flask-restful = pkgs.python35Packages.buildPythonPackage rec {
      name = "Flask-RESTful-${version}";
      version = "0.3.5";
      src = pkgs.fetchurl{
        url = "https://pypi.io/packages/source/f/flask-restful/Flask-RESTful-${version}.tar.gz";
        sha256 = "cce4aeff959b571136b5af098bebe7d3deeca7eb1411c4e722ff2c5356ab4c42";
      };
      buildInputs = with pkgs; [
        python35Packages.nose
      ];
      doCheck = false; # FIXME: Currently fails because of some extraction stuff
      propagatedBuildInputs = with pkgs; [
        aniso8601
        python35Packages.flask
        python35Packages.pytz
        python35Packages.six
      ];
    };

    livereload = pkgs.python35Packages.buildPythonPackage rec {
      name = "livereload-${version}";
      version = "2.5.0";
      src = pkgs.fetchurl {
        url = "mirror://pypi/l/livereload/${name}.tar.gz";
        sha256 = "bc708b46e22dff243c02e709c636ffeb8a64cdd019c95a215304e6ce183c4859";
      };
      propagatedBuildInputs = with pkgs; [
        python35Packages.six
        python35Packages.tornado
      ];
    };

    mkdocs = pkgs.python35Packages.buildPythonPackage rec {
      name = "mkdocs-${version}";
      version = "0.16.0";
      src = pkgs.fetchurl {
        url = "mirror://pypi/m/mkdocs/${name}.tar.gz";
        sha256 = "ab674a1545713af8e2542f3732aa1cc84a233ac008aa1cab81ebab7b7a56bdf7";
      };
      doCheck = false; # FIXME: Some UTF8 errors :-/
      buildInputs = with pkgs; [
        python35Packages.mock
      ];
      propagatedBuildInputs = with pkgs; [
        livereload
        python35Packages.jinja2
        python35Packages.markdown
        python35Packages.pyyaml
        python35Packages.click
        python35Packages.tornado
      ];
    };

    pint = pkgs.python35Packages.buildPythonPackage rec {
      name = "Pint-${version}";
      version = "0.7.2";
      src = pkgs.fetchurl {
        url = "mirror://pypi/p/pint/${name}.tar.gz";
        sha256 = "38b97d352a6376bb4e957095c8b75c1c2aa8edbf9a7ccf058d69b147862e77ad";
      };
    };

    yamlordereddictloader = pkgs.python35Packages.buildPythonPackage rec {
      name = "yamlordereddictloader-${version}";
      version = "0.1.1";
      src = pkgs.fetchFromGitHub {
        owner = "fmenabe";
        repo = "python-yamlordereddictloader";
        rev = "${version}";
        sha256 = "1x1dj33sw22kpbvhcmsf7x3qzqbnajc5i3bian7x2ykwhy8yk1hs";
      };
      propagatedBuildInputs = with pkgs; [
        python35Packages.pyyaml
      ];
    };
  };

in with pkgs; with not_yet_in_nixpkgs; stdenv.mkDerivation rec {
  shellHook = ''
    export PS1="\n\[\033[1;32m\][${name}-shell:\w]$\[\033[0m\] "
  '';
  name = "climvis";
  src = if lib.inNixShell then null else ./.; # Avoid copying of src dir when using nix-shell
  buildInputs = [ stdenv
                # Dependencies which are not yet in nixpkgs
                  flask-restful
                  mkdocs
                  pint
                  yamlordereddictloader
                # Dependencies which are already in nixpkgs
                  python35Packages.flask
                  python35Packages.flask-cors
                  python35Packages.isodate
                  python35Packages.markdown
                  python35Packages.nose
                  python35Packages.numpy
                  python35Packages.pillow
                  python35Packages.pyflakes
                  python35Packages.pygments
                  python35Packages.pyodbc
                  python35Packages.pyparsing
                  python35Packages.pyyaml
                  python35Packages.requests2

  ];
  installPhase= ''
  '';
}
