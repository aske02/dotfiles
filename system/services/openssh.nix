{config, ...}: let
  username = config.var.username;
  sshKeys = config.var.sshKeys;
in {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking.firewall.allowedTCPPorts = [22];

  users.users."${username}".openssh.authorizedKeys.keys = sshKeys;
}
