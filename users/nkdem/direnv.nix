{ config, pkgs, ...}:
let cache_location = 
''
: "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
declare -A direnv_layout_dirs
direnv_layout_dir() {
    local hash path
    echo "''${direnv_layout_dirs[$PWD]:=$(
        hash="$(shasum - <<< "$PWD" | head -c40)"
        path="''${PWD//[^a-zA-Z0-9]/-}"
        echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
    )}"
}
''; # https://github.com/direnv/direnv/wiki/Customizing-cache-location
in 
{
    programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = cache_location;
  };
}