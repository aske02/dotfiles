{
  config,
  lib,
  ...
}: let
  cfg = config.dot.system.programs.steam;
in {
  options.dot.system.programs.steam.enable =
    lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
  };
}
