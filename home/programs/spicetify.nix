{inputs, ...}: {
  imports = [
    inputs.spicetify.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
  };
}
