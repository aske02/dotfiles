{
  config,
  host,
  pkgs,
  ...
}: {
  imports = [
    ../config.nix

    (import ../../home/vm/hyprland {inherit config host pkgs;})

    ../../home/programs/git.nix
    ../../home/programs/shell
    ../../home/programs/tailscale.nix
    ../../home/programs/librewolf.nix
    ../../home/programs/1password.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/vscode.nix
    ../../home/programs/discord.nix
    ../../home/programs/teams.nix
    ../../home/programs/featherpad.nix
    ../../home/programs/zed
    ../../home/programs/beekeeper.nix
    ../../home/programs/opencode.nix

    ../../home/scripts/nixx.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
