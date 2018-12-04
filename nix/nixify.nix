{ pkgs ? import ./nixpkgs {}
, bash ? pkgs.bash
, coreutils ? pkgs.coreutils
, git ? pkgs.git
, jq ? pkgs.jq
, requireFile ? pkgs.requireFile
, runCommand ? pkgs.runCommand
, nixifyImpure ? builtins.readFile ./nixifyImpure.data
}:

runCommand "cardano-cli-src" {
  src = ./..;
  inherit nixifyImpure;
  cratesIoNix = requireFile (builtins.fromJSON nixifyImpure).cratesIoNix;
  buildInputs = [ bash coreutils git jq ];
} ''
  cp -a $src $out
  cd $out
  chmod -R a+w .
  commit_pattern='^160000 (.{40}) '
  for path_key in $(git config -l --name-only -f .gitmodules | grep -E '[.]path$'); do
    path=$(git config --get -f .gitmodules $path_key)
    if ! [[ $(git ls-files -s "$path") =~ $commit_pattern ]]; then continue; fi

    rev=''${BASH_REMATCH[1]}
    section=''${path_key%.path}
    url_key=$section.url

    url_impure_gitlab_github=$(git config -f .gitmodules --get $url_key)
    url_impure_github=''${url_impure_gitlab_github/git@gitlab.com:/https://gitlab.com/}
    url=''${url_impure_github/git@github.com:/https://github.com/}

    rm -rf "$path"
    mkdir "$path"

    jq --arg path "$path" '[$path]' <<< "$nixifyImpure" > "$path/git.json"
    cp nix/template/pin/default.nix "$path/default.nix"
    cp nix/template/pin/git.nix "$path/git.nix"
    cp nix/template/pin/bump.sh "$path/bump.sh"
    jq -r ".cargoNix" <<< "$nixifyImpure" > Cargo.nix
    cp $cratesIoNix crates-io.nix
  done
  cp nix/template/root/default.nix default.nix
  rm -rf .git .gitmodules
  chmod -R a-w .
''
