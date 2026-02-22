{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.discord;
in {
  options.dot.programs.discord.enable = lib.mkEnableOption "Discord";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
