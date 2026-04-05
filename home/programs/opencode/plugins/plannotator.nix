{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dot.programs.opencode;
  system = pkgs.stdenv.hostPlatform.system;
  plannotatorPkg = inputs.self.packages.${system}.plannotator-opencode-plugin;
in {
  config = lib.mkIf (cfg.enable && cfg.addons.plannotator.enable) {
    xdg.configFile."opencode/plugins/plannotator.js".source = "${plannotatorPkg}/plugins/plannotator.js";
    xdg.configFile."opencode/command/plannotator-review.md".source = "${plannotatorPkg}/commands/plannotator-review.md";
    xdg.configFile."opencode/command/plannotator-annotate.md".source = "${plannotatorPkg}/commands/plannotator-annotate.md";
    xdg.configFile."opencode/command/plannotator-archive.md".source = "${plannotatorPkg}/commands/plannotator-archive.md";
    xdg.configFile."opencode/command/plannotator-last.md".source = "${plannotatorPkg}/commands/plannotator-last.md";

    home.sessionVariables = cfg.addons.plannotator.env;
  };
}
