{config, ...}: let
  sshKey = config.var.main_sshKey;
  gh_username = config.var.github.username;
in {
  programs.git = {
    enable = true;

    userName = "aske";
    userEmail = "aske020304@gmail.com";

    signing = {
      key = sshKey;
    };

    extraConfig = {
      github.user = gh_username;
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      commit.gpgSign = true;
    };
  };
}
