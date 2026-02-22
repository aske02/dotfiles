{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.programs.tailscale;
in {
  options.dot.programs.tailscale.enable = lib.mkEnableOption "Tailscale client";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [tailscale];
  };
}
