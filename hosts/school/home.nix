{
  config,
  host,
  pkgs,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};
in {
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

    ../../home/scripts/nixx.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  # BUG: Laptop screen won't return if hdmi is unplugged while external is active
  # Not really sure whats causing it, might be related to https://gitlab.com/w0lff/shikane/-/issues/27
  home.file.".config/shikane/config.toml".source = tomlFormat.generate "config.toml" {
    profile = [
      {
        name = "laptop-only";
        output = [
          {
            search = "eDP-1";
            enable = true;
          }
        ];
        exec = ["notify-send shikane 'Laptop only profile applied'"];
      }
      {
        name = "extern-only";
        output = [
          {
            search = "n%eDP";
            enable = false;
          }
          {
            search = "n%HDMI-";
            mode = "preferred";
            enable = true;
          }
        ];
        exec = ["notify-send shikane 'External only profile applied'"];
      }
    ];
  };
}
