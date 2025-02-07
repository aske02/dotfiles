if [[ "$(uname -n)" == "nixos" ]]; then
    sudo nixos-rebuild switch --flake ./nix#wsl
fi
