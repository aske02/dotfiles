{inputs, ...}: {
  imports = [
    ./programs
    ./scripts
    ./shell
    ./wm

    inputs.auxera-pkgs.homeManagerModules.default
  ];
}
