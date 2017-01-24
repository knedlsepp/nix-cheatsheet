with import <nixpkgs> {};
(
let
  packageOverrides = self: super: {
    flask = super.flask.overrideDerivation (oldAttrs: {
      name = "flask-0.12";
      src = fetchurl {
        url = "https://pypi.python.org/packages/4b/3a/4c20183df155dd2e39168e35d53a388efb384a512ca6c73001d8292c094a/Flask-0.12.tar.gz";
        sha256 = "12yasybryp33rdchsqgckf15zj4pjfam7ly5spmn2sijpv6h7s4k";
      };
    });
  };
in (pkgs.python35.override {inherit packageOverrides;}).withPackages (ps: [ps.flask_login ps.numpy])
).env

