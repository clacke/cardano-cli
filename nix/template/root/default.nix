{ pkgs ? import ./nix/nixpkgs {}
, callPackage ? pkgs.callPackage
, cargoNix ? callPackage ./Cargo.nix { inherit cratesIO; }
, cratesIO ? callPackage ./crates-io.nix {}
}:

cargoNix.cardano_cli {}
