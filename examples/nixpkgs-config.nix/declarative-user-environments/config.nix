{ 
  allowUnfree = true;
  allowBroken = true;
  packageOverrides = pkgs: rec {
    # Install via
    #   nix-env -iA nixpkgs.my-default-toolset
    my-default-toolset = pkgs.buildEnv {
      name = "my-default-toolset";
      paths = with pkgs; [
        cmakeCurses
        fish
        gdal
        wget
        gitAndTools.gitFull
        htop
        # meld
        nixops
        # pandoc # This is not exactly lightweight
        ponysay
        tree
        vagrant
      ] ++ stdenv.lib.optionals (stdenv.isLinux) [ 
        atom
      ];
    };
    # Start via:
    #   nix-shell -p nixpkgs.cxx-dev-env
    cxx-dev-env = pkgs.buildEnv {
      name = "my-dev-env";
      paths = with pkgs; [
        cgdb
        valgrind
      ] ++ stdenv.lib.optionals (stdenv.isLinux) [ 
        readelf
      ];
    };
  };
}
