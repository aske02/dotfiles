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
    ../../home/programs/firefox.nix
    ../../home/programs/librewolf.nix
    ../../home/programs/1password.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/vscode.nix
    ../../home/programs/discord.nix
    ../../home/programs/teams.nix
    ../../home/programs/featherpad.nix

    ../../home/scripts/nixx.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/${config.var.username}";

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  home.file.".config/hypr/monitor-switch.sh".executable = true;
  home.file.".config/hypr/monitor-switch.sh".text = ''
    LAPTOP=$(hyprctl monitors | grep -E 'eDP|LVDS' | awk '{print $2}')
    HDMI=$(hyprctl monitors | grep -E 'HDMI' | awk '{print $2}')

    if [ -n "$HDMI" ] && hyprctl monitors | grep -q "$HDMI"; then
        hyprctl dispatch dpms off "$LAPTOP"
        hyprctl dispatch dpms on "$HDMI"
        hyprctl keyword monitor "$LAPTOP,disable"
        hyprctl keyword monitor "$HDMI,1920x1080@60,0x0,1"
    else
        hyprctl dispatch dpms on "$LAPTOP"
        hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1"
        [ -n "$HDMI" ] && hyprctl keyword monitor "$HDMI,disable"
    fi
  '';
}
