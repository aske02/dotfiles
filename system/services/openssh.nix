{ config, lib, ... }:
let
  cfg = config.dot.system.services.openssh;
  username = config.var.username;
  sshKeys = config.var.sshKeys;
in {
  options.dot.system.services.openssh.enable =
    lib.mkEnableOption "OpenSSH server";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    networking.firewall.allowedTCPPorts = [22];

    users.users."${username}".openssh.authorizedKeys.keys = sshKeys;
  };
}
