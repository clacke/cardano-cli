#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "${BASH_SOURCE[0]%/*}" && pwd)

"$SCRIPT_DIR"/nixify.sh --no-out-link | xargs nix-build "$@"
