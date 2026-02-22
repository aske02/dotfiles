{config, ...}: {
  imports = [
    ../config.nix

    ../../home
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  dot.programs.git.enable = true;
  dot.programs.opencode.enable = true;

  dot.shell.enable = true;
}
