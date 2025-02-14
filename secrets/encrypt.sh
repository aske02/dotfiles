cd $HOME/dotfiles/secrets || exit 1

if [ -n "$1" ]; then
    service_token="$1"
elif [ -f /run/secrets/1password/service_token ]; then
    service_token=$(cat /run/secrets/1password/service_token)
else
    echo "Error: No input provided and service token file is missing!" >&2
    exit 1
fi

export OP_SERVICE_ACCOUNT_TOKEN=$service_token

cat ./secrets.template.yaml | op inject | sops --encrypt /dev/stdin > ./secrets.enc.yaml

unset OP_SERVICE_ACCOUNT_TOKEN