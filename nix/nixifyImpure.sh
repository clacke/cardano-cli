#!/usr/bin/env nix-shell
#! nix-shell --pure -p bash coreutils git nix-prefetch-git -i bash

set -euo pipefail

cd "${BASH_SOURCE[0]%/*}"
cd "$(git rev-parse --show-toplevel)"

commit_pattern='^160000 (.{40}) '
attrs=()
for path_key in $(git config -l --name-only -f .gitmodules | grep -E '[.]path$'); do
  path=$(git config --get -f .gitmodules $path_key)
  if ! [[ $(git ls-files -s "$path") =~ $commit_pattern ]]; then continue; fi

  rev=${BASH_REMATCH[1]}
  section=${path_key%.path}
  url_key=$section.url
  url_impure_gitlab_github=$(git config -f .gitmodules --get $url_key)
  url_impure_github=${url_impure_gitlab_github/git@gitlab.com:/https://gitlab.com/}
  url=${url_impure_github/git@github.com:/https://github.com/}
  attrs+=("\"$path\": $(nix-prefetch-git "$url" "$rev")")
done

cat <<EOF
{
  $(
    for attr in "${attrs[@]:0:$((${#attrs[@]}-1))}"; do
      echo "${attr},"
    done
  )
  ${attrs[@]:$((${#attrs[@]}-1))}
}
EOF
