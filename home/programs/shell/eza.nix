{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--git-ignore"
      "--icons=always"
    ];
  };

  shellAliases = {
    ls = "eza --icons -T -L=1";
    sl = "ls";
    tree = "eza --icons -T";
  };
}
