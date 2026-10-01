{config, ...}: {
  imports = [
    ../../home/shell

    ../../home/programs/zed
    ../../home/programs/1password.nix
    ../../home/programs/discord.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/git.nix
    ../../home/programs/librewolf.nix
    ../../home/programs/ssh.nix
    ../../home/programs/tailscale.nix

    ../../home/scripts/nixx.nix

    ../../home/wm/hyprland
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;

  dot.programs.ghostty.forceSoftwareRendering = true;
}
