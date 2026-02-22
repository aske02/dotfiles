{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.git;
  sshKey = config.var.main_sshKey;
  gh_username = config.var.github.username;
in {
  options.dot.programs.git.enable = lib.mkEnableOption "Git";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "aske";
          email = "aske020304@gmail.com";
        };

        github.user = gh_username;
        push.autoSetupRemote = true;
        gpg.format = "ssh";
        commit.gpgSign = true;
      };

      signing = {
        key = sshKey;
      };
    };
  };
}
