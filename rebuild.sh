if [[ "$(uname -n)" == "felix.berger" ]]; then
    darwin-rebuild switch --flake ./nix/
elif [[ "$(uname -n)" == "nixos" ]]; then
    sudo nixos-rebuild switch --flake ./nix#wsl
fi