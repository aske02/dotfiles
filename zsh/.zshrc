# Starship
export STARSHIP_CONFIG=~/.config/starship.toml

eval "$(starship init zsh)"

# fzf
source <(fzf --zsh)

if [[ "$(uname -n)" == "nixos" ]]; then
  source ~/.ssh_pipe
fi

alias ns='nix-shell --command $SHELL'