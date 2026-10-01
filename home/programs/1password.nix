{
  lib,
  pkgs,
  ...
}: let
  onePassPath = "~/.1password/agent.sock";
in {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        identityAgent = "${onePassPath}";
      };
    };
  };

  programs.git.settings.gpg.ssh = {
    program = lib.mkForce "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
  };
}
