{ pkgs ? import <nixpkgs> {} }:
with pkgs;
stdenv.mkDerivation rec {
  name = "saphir";
  src = ./.;
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
