{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.vscode;
in {
  options.dot.programs.vscode.enable = lib.mkEnableOption "VS Code";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
