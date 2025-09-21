{inputs, ...}: {
  imports = [inputs.caelestia.homeManagerModules.default];
  programs.caelestia = {
    enable = true;
    systemd.enable = false;
    cli = {
      enable = true;
      extraConfig = builtins.readFile ./cli.json;
    };
    extraConfig = builtins.readFile ./config.json;
  };
}
