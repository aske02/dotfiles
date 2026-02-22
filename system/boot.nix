{ config, lib, ... }:
let
  cfg = config.dot.system.features.boot;
in {
  options.dot.system.features.boot.enable =
    lib.mkEnableOption "Bootloader and basic boot settings";

  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi = {
          canTouchEfiVariables = true;
        };
      };
      tmp.cleanOnBoot = true;
    };
  };
}
