{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.shell;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
    ];

    dot.shell.aliases.cat = "bat --paging=never --color=always --tabs=4 --wrap=never --theme=Dracula --plain";
  };
}
