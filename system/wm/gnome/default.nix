{
  config,
  lib,
  ...
}: let
  cfg = config.dot.system.wm.gnome;
in {
  options.dot.system.wm.gnome.enable =
    lib.mkEnableOption "GNOME desktop";

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "dk";
      variant = "";
    };
  };
}
