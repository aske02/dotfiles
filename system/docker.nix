{config, ...}: let
  username = config.var.username;
in {
  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = ["docker"];
}
