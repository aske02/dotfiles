{pkgs, ...}: {
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

    shellAliases = {
      cat = "bat --paging=never --color=always --tabs=4 --wrap=never --theme=Dracula --plain";

      cd = "z";

      ls = "eza --icons -T -L=1";
      sl = "ls";
      tree = "eza --icons -T";

      fetch = "onefetch";
      gitfetch = "onefetch";

      nix-shell = "nix-shell --command zsh";

      zed = "zeditor";
    };

    initContent = ''
      ${pkgs.neofetch}/bin/neofetch
    '';
  };
}
