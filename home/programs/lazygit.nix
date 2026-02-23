{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.lazygit;
in {
  options.dot.programs.lazygit.enable = lib.mkEnableOption "Lazygit";

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}