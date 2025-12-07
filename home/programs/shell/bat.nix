{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
  ];

  shellAliases = {
    cat = "bat --paging=never --color=always --tabs=4 --wrap=never --theme=Dracula --plain";
  };
}
