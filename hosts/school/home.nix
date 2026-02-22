{
  config,
  host,
  pkgs,
  ...
}: {
  imports = [];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  dot = {
    programs = {
      git.enable = true;
      onepassword.enable = true;
      ghostty.enable = true;
      zed.enable = true;
      vscode.enable = true;
      discord.enable = true;
      teams.enable = true;
      featherpad.enable = true;
      beekeeper.enable = true;
      tailscale.enable = true;
      librewolf.enable = true;
      opencode.enable = true;
    };

    shell.enable = true;

    wm.hyprland.enable = true;
  };
}
