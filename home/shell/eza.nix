{
  config,
  lib,
  ...
}: let
  cfg = config.dot.shell;
in {
  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableZshIntegration = cfg.zsh.enable;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
        "--no-quotes"
        "--icons=always"
      ];
    };

    dot.shell.aliases = {
      ls = "eza --icons -T -L=1";
      sl = "ls";
      tree = "eza --icons -T";
    };
  };
}
