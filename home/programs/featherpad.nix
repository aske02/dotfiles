{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.featherpad;
in {
  options.dot.programs.featherpad.enable = lib.mkEnableOption "FeatherPad";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      featherpad
    ];
  };
}
