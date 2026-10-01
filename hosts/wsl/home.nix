{config, ...}: {
  imports = [
    ../../home/shell

    ../../home/programs/opencode
    ../../home/programs/git.nix
    ../../home/programs/lazygit.nix
    ../../home/programs/ssh.nix
    ../../home/programs/tailscale.nix

    ../../home/scripts/nixx.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  dot.programs = {
    opencode = {
      addons = {
        plannotator.enable = false;
        notifier.sound = true;
        notifier.notification = false;
      };
    };
  };
}
