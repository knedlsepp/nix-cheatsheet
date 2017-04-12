{ pkgs ? import <nixpkgs> {} }:
with pkgs;
stdenv.mkDerivation rec {
  name = "saphir";
  src = if lib.inNixShell then null else ./.; # Avoid copying of src dir when using nix-shell
  buildInputs = [ stdenv
                # Actual dependencies
                  armadillo
                  boost
                  catch
                  cmake
                  nanoflann
                  proj
                  gdal
                  zlib
                  grib-api
                  gfortran
    ];
  enableParallelBuilding = true;
}
