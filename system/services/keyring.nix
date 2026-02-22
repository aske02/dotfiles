{ config, lib, ... }:
let
  cfg = config.dot.system.services.keyring;
in {
  options.dot.system.services.keyring.enable =
    lib.mkEnableOption "GNOME keyring";

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
