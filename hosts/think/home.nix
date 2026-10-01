{config, ...}: {
  imports = [];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;

  dot = {
    programs = {
      git.enable = true;
      lazygit.enable = true;
      onepassword.enable = true;
      zed.enable = true;
      vscode.enable = false;
      discord.enable = true;
      teams.enable = false;
      featherpad.enable = false;
      beekeeper.enable = true;
      tailscale.enable = true;
      librewolf.enable = true;
      opencode.enable = true;
      spicetify.enable = true;
      ghostty = {
        enable = true;
        forceSoftwareRendering = true;
      };
    };

    shell.enable = true;

    wm.hyprland.enable = true;
  };
}
