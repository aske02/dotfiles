{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.onepassword;
  onePassPath = "~/.1password/agent.sock";
in {
  options.dot.programs.onepassword.enable = lib.mkEnableOption "1Password integration";

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          identityAgent = "${onePassPath}";
        };
      };
    };

    programs.git.settings = {
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
    };
  };
}
