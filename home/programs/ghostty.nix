{...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      keybind = [
        "performable:ctrl+v=paste_from_clipboard"
        "performable:ctrl+c=copy_to_clipboard"
      ];
    };
  };
}
