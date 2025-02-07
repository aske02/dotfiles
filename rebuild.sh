if [[ "$(uname -n)" == "nixos" ]]; then
    sudo nixos-rebuild switch --flake $HOME/dotfiles/nix#wsl
fi
