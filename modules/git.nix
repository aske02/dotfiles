{
  config,
  pkgs,
  me,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "Aske";
    userEmail = "aske020304@gmail.com";

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBuGWVW12wKcCYaHAZABfS3opkJlf/JC9Yo3xMRq6wyp";
    };

    extraConfig = {
      github.user = me.pass;
      core.sshCommand = "ssh.exe";
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      commit.gpgSign = true;
    };
  };
}
