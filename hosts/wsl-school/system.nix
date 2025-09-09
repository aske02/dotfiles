{
  config,
  pkgs,
  host,
  ...
}: (import ../wsl/system.nix {inherit config pkgs host;})
