{pkgs, ...}: {
  imports = [
    ./starship.nix
    ./zsh.nix
    ./eza.nix
  ];

  home.packages = with pkgs; [
    onefetch
    bat
    killall
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    silent = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
