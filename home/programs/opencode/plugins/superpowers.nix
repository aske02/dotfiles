{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.opencode;
in {
  config = lib.mkIf (cfg.enable && cfg.addons.superpowers.enable) {
    programs.superpowers-opencode-plugin.enable = true;
  };
}
