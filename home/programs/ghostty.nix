{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.ghostty;
  ghosttyLlvmpipe = pkgs.symlinkJoin {
    name = "ghostty-llvmpipe";
    paths = [pkgs.ghostty];
    nativeBuildInputs = [pkgs.makeWrapper];
    meta.mainProgram = "ghostty";
    postBuild = ''
      wrapProgram $out/bin/ghostty --set LIBGL_ALWAYS_SOFTWARE 1
    '';
  };
in {
  options.dot.programs.ghostty = {
    forceSoftwareRendering =
      lib.mkEnableOption "force software (llvmpipe) OpenGL rendering"
      // {
        default = false;
      };
  };

  config = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      package = lib.mkIf cfg.forceSoftwareRendering ghosttyLlvmpipe;
      settings = {
        keybind = [
          "performable:ctrl+v=paste_from_clipboard"
          "performable:ctrl+c=copy_to_clipboard"
        ];
      };
    };
  };
}
