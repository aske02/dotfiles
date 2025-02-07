if [[ "$(uname -n)" == "Felixs-MacBook-Air.local" ]]; then
    darwin-rebuild switch --flake ./nix/
elif [[ "$(uname -n)" == "nixos" ]]; then
    sudo nixos-rebuild switch --flake ./nix#wsl
fi
