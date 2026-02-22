{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.ghostty;
in {
  options.dot.programs.ghostty.enable = lib.mkEnableOption "Ghostty";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        keybind = [
          "performable:ctrl+v=paste_from_clipboard"
          "performable:ctrl+c=copy_to_clipboard"
        ];
      };
    };
  };
}
