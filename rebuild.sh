git add secrets/secrets.enc.yaml -f

if [[ "$(uname -n)" == "nixos" ]]; then
    sudo nixos-rebuild switch --flake .#wsl
fi

git remove secrets/secrets.enc.yaml