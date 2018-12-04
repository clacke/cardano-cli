{ pkgs ? import ./nix/nixpkgs {}
, callPackage ? pkgs.callPackage
, cargoNix ? callPackage ./Cargo.nix { inherit cratesIO; }
, cratesIO ? callPackages ./crates-io.nix
}:

cargoNix.cardano_cli {}
