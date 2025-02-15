cd "$(dirname "$0")"

if [ -n "$1" ]; then
    service_token="$1"
elif [ -f /run/secrets/1password/service_token ]; then
    service_token=$(cat /run/secrets/1password/service_token)
else
    echo "Error: No input provided and service token file is missing!" >&2
    exit 1
fi

declare -A templates
templates=(
  ["wsl"]="./templates/wsl.yaml"
)

selected=$(printf "%s\n" "${!templates[@]}" | fzf --prompt="Select system template: ")
selected_path=${templates[$selected]}

export OP_SERVICE_ACCOUNT_TOKEN=$service_token

cat $selected_path | op inject | sops --encrypt /dev/stdin > ./secrets.enc.yaml

unset OP_SERVICE_ACCOUNT_TOKEN