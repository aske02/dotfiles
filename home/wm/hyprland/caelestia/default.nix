{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.dot.wm.hyprland;
in {
  imports = [inputs.caelestia.homeManagerModules.default];

  config = lib.mkIf cfg.enable {
    programs.caelestia = {
      enable = true;
      systemd.enable = false;
      cli = {
        enable = true;
        extraConfig = builtins.readFile ./cli.json;
      };
      extraConfig = builtins.readFile ./config.json;
    };
  };
}
