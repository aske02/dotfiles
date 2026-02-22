{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.dot.programs.spicetify;
in {
  options.dot.programs.spicetify.enable = lib.mkEnableOption "Spicetify";

  imports = [
    inputs.spicetify.homeManagerModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.spicetify.enable = true;
  };
}
