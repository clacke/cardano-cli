#!/usr/bin/env bash

./nixifyImpure.sh | xargs -0 nix-build "$@" nixify.nix --argstr nixifyImpure
