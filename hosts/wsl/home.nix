{config, ...}: {
  imports = [
    ../config.nix

    ../../home/programs/git.nix
    ../../home/programs/shell
    ../../home/programs/tailscale.nix
    ../../home/programs/opencode.nix

    ../../home/scripts/nixx.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
