{inputs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      caelestia-shell = inputs.caelestia.packages.${prev.system}.caelestia-shell;
      caelestia-cli = inputs.caelestia.inputs.caelestia-cli.packages.${prev.system}.caelestia-cli;
    })
  ];
}
