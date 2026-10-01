{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.opencode;
  notifierCfg = cfg.addons.notifier;
in {
  config = lib.mkIf notifierCfg.enable {
    programs.opencode-notifier-plugin = {
      enable = true;
      settings = {
        sound = notifierCfg.sound;
        notification = notifierCfg.notification;
      };
    };
  };
}
