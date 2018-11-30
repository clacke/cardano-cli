{ pkgs ? import ./nix/nixpkgs {}
, callPackage ? pkgs.callPackage
, cargoNix ? callPackage ./Cargo.nix { inherit cratesIO; }
, cratesIO ? pkgs.cratesIO
}:

cargoNix.cardano_cli {}
