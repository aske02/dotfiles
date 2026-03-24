{config, ...}: {
  imports = [];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  dot.programs = {
    git.enable = true;
    lazygit.enable = true;
    opencode = {
      enable = true;
      addons = {
        notifier.soundOnly = true;
        notifier.settings.suppressWhenFocused = false;
        notifier.volumes = {
          permission = 0.5;
          complete = 0.5;
          error = 0.5;
          question = 0.5;
          subagent_complete = 0.5;
        };

        plannotator.env = {
          PLANNOTATOR_BROWSER = "librewolf.exe";
        };
      };
    };
  };

  dot.shell.enable = true;
}
