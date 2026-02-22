{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.system.programs.onepassword;
  username = config.var.username;
  hmEnable =
    lib.attrByPath
    ["home-manager" "users" username "dot" "programs" "onepassword" "enable"]
    false
    config;
  enabled = cfg.enable || hmEnable;
in {
  options.dot.system.programs.onepassword.enable =
    lib.mkEnableOption "1Password (system)";

  config = lib.mkIf enabled {
    programs._1password.enable = true;
    programs._1password-gui.enable = true;

    environment.systemPackages = [
      pkgs._1password-cli
    ];
  };
}
