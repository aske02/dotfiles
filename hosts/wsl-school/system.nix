{
  config,
  pkgs,
  lib,
  host,
  ...
}: (import ../wsl/system.nix {inherit config pkgs lib host;})
