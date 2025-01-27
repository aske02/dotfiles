{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "felix.berger";
  home.homeDirectory = "/Users/felix.berger";

  home.packages = [];

  home.file = {
    ".zshrc".source = ../zsh/.zshrc;
    ".gitconfig".source = ../git/.gitconfig;
    ".gitignore_global".source = ../git/.gitignore_global;
    ".config/zed/settings.json".source = ../zed/settings.json;
    ".config/zed/tasks.json".source = ../zed/tasks.json;
    ".config/starship".source = ../starship;
    #".config/tmux".source = ../tmux;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
