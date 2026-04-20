{
  config,
  lib,
  ...
}: let
  cfg = config.dot.shell;
in {
  config = lib.mkIf cfg.enable {
    programs.gh = {
      enable = true;
    };
  };
}
