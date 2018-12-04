#!/usr/bin/env bash

cd "${BASH_SOURCE[0]%/*}"

./nixifyImpure.sh | xargs -0 nix-build "$@" nixify.nix --argstr nixifyImpure
