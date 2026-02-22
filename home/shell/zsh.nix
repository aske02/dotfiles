{
  config,
  lib,
  ...
}: let
  cfg = config.dot.shell;
in {
  config = lib.mkIf (cfg.enable && cfg.zsh.enable) {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      autosuggestion.highlight = null;
      syntaxHighlighting.enable = false;

      history = {
        ignoreDups = true;
        save = 10000;
        size = 10000;
      };

      oh-my-zsh = {
        enable = true;
        plugins = ["git" "direnv" "fzf" "docker" "eza" "zoxide"];
        theme = ""; # Starship needs this empty
      };
    };
  };
}
