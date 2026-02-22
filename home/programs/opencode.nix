{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dot.programs.opencode;
  opencode = inputs.opencode;
  system = pkgs.stdenv.hostPlatform.system;
in {
  options.dot.programs.opencode.enable = lib.mkEnableOption "OpenCode";

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;
      package = opencode.packages.${system}.default;
    };
  };
}
