{
  config,
  lib,
  pkgs,
  ...
}: let
  username = config.var.username;
  cfg = config.dot.system.core.user;
in {
  options.dot.system.core.user.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable base user account and shell defaults.";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;
    users = {
      defaultUserShell = pkgs.zsh;

      users.${username} = {
        isNormalUser = true;
        description = "${username} account";
        extraGroups = ["networkmanager" "wheel"];
      };
    };
  };
}
