{ pkgs ? import ./nix/nixpkgs {}
, callPackage ? pkgs.callPackage
, cargoNix ? callPackage ./Cargo.nix {}
}:

cargoNix.cardano_cli {}
