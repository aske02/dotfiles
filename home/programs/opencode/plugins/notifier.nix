{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dot.programs.opencode;
  notifierCfg = cfg.addons.notifier;
  system = pkgs.stdenv.hostPlatform.system;
  notifierPkg = inputs.self.packages.${system}.opencode-notifier-plugin;

  effectiveSound =
    if notifierCfg.soundOnly
    then true
    else notifierCfg.sound;

  effectiveNotification =
    if notifierCfg.soundOnly
    then false
    else notifierCfg.notification;

  defaultSettings = {
    sound = effectiveSound;
    notification = effectiveNotification;
    timeout = 5;
    showProjectName = true;
    showSessionTitle = false;
    showIcon = true;
    suppressWhenFocused = true;
    enableOnDesktop = false;
    notificationSystem = "osascript";

    linux.grouping = false;

    volumes = {
      permission = notifierCfg.volumes.permission;
      complete = notifierCfg.volumes.complete;
      subagent_complete = notifierCfg.volumes.subagent_complete;
      error = notifierCfg.volumes.error;
      question = notifierCfg.volumes.question;
    };
  };

  notifierSettings = lib.recursiveUpdate defaultSettings notifierCfg.settings;
in {
  config = lib.mkIf (cfg.enable && notifierCfg.enable) {
    xdg.configFile."opencode/plugins/opencode-notifier.js".source = "${notifierPkg}/plugins/opencode-notifier.js";
    xdg.configFile."opencode/logos".source = "${notifierPkg}/logos";
    xdg.configFile."opencode/sounds".source = "${notifierPkg}/sounds";

    xdg.configFile."opencode/opencode-notifier.json".text = builtins.toJSON notifierSettings;
  };
}
