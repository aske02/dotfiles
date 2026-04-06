{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dot.programs.opencode;
  notifierCfg = cfg.addons.notifier;
in {
  config = lib.mkIf (cfg.enable && notifierCfg.enable) {
    programs.opencode-notifier-plugin = {
      enable = true;
      settings = {
        sound = notifierCfg.sound;
        notification = notifierCfg.notification;
      };
    };
  };
}
