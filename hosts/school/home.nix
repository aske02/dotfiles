{config, ...}: {
  imports = [
    ../../home/shell

    ../../home/programs/opencode
    ../../home/programs/zed
    ../../home/programs/1password.nix
    ../../home/programs/beekeeper.nix
    ../../home/programs/discord.nix
    ../../home/programs/featherpad.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/git.nix
    ../../home/programs/lazygit.nix
    ../../home/programs/librewolf.nix
    ../../home/programs/ssh.nix
    ../../home/programs/tailscale.nix
    ../../home/programs/teams.nix

    ../../home/scripts/nixx.nix
    ../../home/scripts/hyprdynamicmonitors-tui.nix

    ../../home/wm/hyprland
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  dot.wm.hyprland.hyprmonitors.enable = true;

  dot.programs = {
    opencode = {
      addons = {
        plannotator.enable = false;
        notifier.sound = false;
        notifier.notification = true;
      };
    };
  };
}
