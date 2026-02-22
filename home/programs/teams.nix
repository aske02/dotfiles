{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.teams;
in {
  options.dot.programs.teams.enable = lib.mkEnableOption "Teams (teams-for-linux)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      teams-for-linux
    ];
  };
}
