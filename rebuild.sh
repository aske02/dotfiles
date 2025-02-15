if [[ "$(uname -n)" == "nixos" ]]; then
    sudo nixos-rebuild switch --flake .#wsl
fi
