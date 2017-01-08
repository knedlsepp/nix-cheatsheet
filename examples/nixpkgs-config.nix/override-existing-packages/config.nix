{ 
  packageOverrides = pkgs: rec {
    # Make "grib-api" build the python extensions
    grib-api = pkgs.grib-api.override {
      enablePython = true;
    };
    # Use different sed version than in nixpkgs
    gnused = pkgs.gnused.overrideDerivation (oldAttrs: {
      name = "sed-4.2.2-pre";
      src = fetchurl {
        url = ftp://alpha.gnu.org/gnu/sed/sed-4.2.2-pre.tar.bz2;
        sha256 = "11nq06d131y4wmf3drm0yk502d2xc6n5qy82cg88rb9nqd2lj41k";
      };
      patches = [];
    });
  };
}
