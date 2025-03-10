cd "$(dirname "$0")"

if [ -n "$1" ]; then
  CONFIG_NAME="$1"
  echo "Using configuration from argument: $CONFIG_NAME"
elif [ -n "$NIXOS_CONFIG_NAME" ]; then
  CONFIG_NAME="$NIXOS_CONFIG_NAME"
  echo "Using configuration from NIXOS_CONFIG_NAME: $CONFIG_NAME"
else
  OPTIONS=("wsl" "wsl-school")
  CONFIG_NAME=$(
    printf "%s\n" "${OPTIONS[@]}" | fzf --prompt="Select configuration: " --height 5
  )

  if [ -z "$CONFIG_NAME" ]; then
    echo "No configuration selected. Exiting."
    exit 1
  fi
fi

git add secrets/secrets.enc.yaml -f

sudo nixos-rebuild switch --flake ".#${CONFIG_NAME}"

git restore --staged secrets/secrets.enc.yaml
