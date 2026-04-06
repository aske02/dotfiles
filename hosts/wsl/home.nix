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
        notifier.sound = true;
        notifier.notification = false;
      };
    };
  };

  dot.shell.enable = true;
}
