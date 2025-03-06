{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services."1password-agent";
in {
  options.services."1password-agent" = {
    npiperelayPath = mkOption {
      type = types.str;
      default = "/mnt/c/bin/npiperelay.exe";
      description = "Path to npiperelay.exe";
    };
  };

  config = {
    systemd.services."1password-agent" = {
      description = "1Password SSH Agent Relay";
      wantedBy = ["multi-user.target"];
      path = [pkgs.socat];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.bash}/bin/bash -c " \
            rm -f /run/1password-agent.sock; \
            exec ${pkgs.socat}/bin/socat \
              UNIX-LISTEN:/run/1password-agent.sock,fork,mode=0666 \
              EXEC:'${cfg.npiperelayPath} -ei -s //./pipe/openssh-ssh-agent',nofork \
          "
        '';
        Restart = "always";
        RestartSec = 5;
        User = "root";
        RuntimeDirectory = "1password-agent";
        RuntimeDirectoryMode = "0755";
      };
    };

    environment.variables = {
      SSH_AUTH_SOCK = "/run/1password-agent.sock";
    };
  };
}
