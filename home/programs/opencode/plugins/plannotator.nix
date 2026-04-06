{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.opencode;
in {
  config = lib.mkIf (cfg.enable && cfg.addons.plannotator.enable) {
    programs.plannotator-opencode-plugin.enable = true;
  };
}
