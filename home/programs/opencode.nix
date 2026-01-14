{
  pkgs,
  inputs,
  ...
}: let
  opencode = inputs.opencode;
in {
  programs.opencode = {
    enable = true;
    package = opencode.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
