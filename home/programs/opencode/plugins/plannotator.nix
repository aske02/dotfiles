{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.opencode;
in {
  config = lib.mkIf cfg.addons.plannotator.enable {
    programs.plannotator-opencode-plugin.enable = true;
  };
}
