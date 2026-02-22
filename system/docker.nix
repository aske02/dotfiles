{
  config,
  lib,
  ...
}: let
  cfg = config.dot.system.features.docker;
  username = config.var.username;
in {
  options.dot.system.features.docker.enable =
    lib.mkEnableOption "Docker";

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${username}.extraGroups = ["docker"];
  };
}
