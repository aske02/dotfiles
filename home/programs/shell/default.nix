{pkgs, ...}: {
  imports = [
    ./aliases.nix
    ./starship.nix
    ./zsh.nix
    ./eza.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    onefetch
    killall
    alejandra
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

  shellAliases = {
    cd = "z";

    nix-shell = "nix-shell --command zsh";

    fetch = "onefetch";
    gitfetch = "onefetch";
  };
}
