{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.shell.tmux;
in {
  imports = [
    ./tmux.nix
    ./sessionizer.nix
  ];

  options.dot.shell.tmux = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tmux configuration.";
    };

    sessionizer.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tmux sessionizer script.";
    };
  };
}
