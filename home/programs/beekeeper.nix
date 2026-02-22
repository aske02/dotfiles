{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.beekeeper;
in {
  options.dot.programs.beekeeper.enable = lib.mkEnableOption "Beekeeper Studio";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      beekeeper-studio
    ];
  };
}
