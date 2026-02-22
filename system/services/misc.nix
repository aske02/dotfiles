{ config, lib, ... }:
let
  cfg = config.dot.system.services.upower;
in {
  options.dot.system.services.upower.enable =
    lib.mkEnableOption "upower";

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
  };
}
