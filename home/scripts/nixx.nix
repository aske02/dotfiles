{
  config,
  pkgs,
  ...
}: let
  dotfiles = config.var.dotfiles;

  nixx =
    pkgs.writeShellScriptBin "nixx"
    ''
      if [[ $1 == "rebuild" ]]; then
        cd ${dotfiles} && \
        git add . && \
        sudo nixos-rebuild switch --flake && \
      elif [[ $1 == "test" ]]; then
        cd ${dotfiles} && sudo nixos-rebuild test --flake
      elif [[ $1 == "switch" && -n $2 ]]; then
        cd ${dotfiles} && \
        git add . && \
        sudo nixos-rebuild switch --flake .#$2 && \
      else
        echo "Unknown argument"
      fi
    '';
in {
  home.packages = [nixx];
}
