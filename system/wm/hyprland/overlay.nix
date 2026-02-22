{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      caelestia-shell = inputs.caelestia.packages.${pkgs.system}.caelestia-shell;
      caelestia-cli = inputs.caelestia.inputs.caelestia-cli.packages.${pkgs.system}.caelestia-cli;
    })
  ];
}
