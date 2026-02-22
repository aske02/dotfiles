{ config, lib, ... }:
let
  cfg = config.dot.system.services.keyd;
in {
  options.dot.system.services.keyd.enable =
    lib.mkEnableOption "keyd";

  config = lib.mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          "leftcontrol+leftalt" = "layer(altgr)";
        };
      };
    };
  };
}
