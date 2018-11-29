#!/usr/bin/env nix-shell
#! nix-shell -p bash coreutils git nix nix-prefetch-git -i bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}"
cd "$(git rev-parse --show-toplevel)"

commit_pattern='^160000 (.{40}) '
unset attrs
declare -A attrs
for path_key in $(git config -l --name-only -f .gitmodules | grep -E '[.]path$'); do
  path=$(git config --get -f .gitmodules $path_key)
  if ! [[ $(git ls-files -s "$path") =~ $commit_pattern ]]; then continue; fi

  rev=${BASH_REMATCH[1]}
  section=${path_key%.path}
  url_key=$section.url
  url_impure_gitlab_github=$(git config -f .gitmodules --get $url_key)
  url_impure_github=${url_impure_gitlab_github/git@gitlab.com:/https://gitlab.com/}
  url=${url_impure_github/git@github.com:/https://github.com/}
  attrs+=( [$path]=$(nix-prefetch-git "$url" "$rev") )
done

unset paths
paths=("${!attrs[@]}")

unset nix_paths
declare -A nix_paths

for path in "${paths[@]}"; do
  nix_paths+=([$path]="$(nix-build --no-out-link --argstr json "${attrs[$path]}" -E '{json}: with import <nixpkgs> {}; fetchgit (builtins.removeAttrs (builtins.fromJSON json) ["date"])')")
done

cat <<EOF
{
  $(for path in "${paths[@]}"; do
    echo "\"$path\": ${attrs[$path]},"
  done)
  "@nix_paths": {
    $(for path in "${paths[@]:0:$((${#paths[@]}-1))}"; do
      echo "\"$path\": \"${nix_paths[$path]}\","
    done)
    "${paths[-1]}": "${nix_paths[${paths[-1]}]}"
  }
}
EOF
