{
  config,
  lib,
  ...
}: let
  cfg = config.dot.system.features.sops;
in {
  options.dot.system.features.sops.enable =
    lib.mkEnableOption "SOPS secret management";

  config = lib.mkIf cfg.enable {
    sops.defaultSopsFile = ../secrets/secrets.enc.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "home/" + config.var.username + "/.config/sops/keys.txt";
  };
}
