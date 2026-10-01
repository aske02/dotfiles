{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.shell;

  preferredShell =
    if cfg.preferred == "zsh"
    then "zsh"
    else "bash";

  defaultAliases = {
    cd = "z";

    nix-shell = "nix-shell --command ${preferredShell}";

    fetch = "onefetch";
    gitfetch = "onefetch";
  };
in {
  imports = [
    ./starship.nix
    ./zsh.nix
    ./eza.nix
    ./bat.nix
    ./gh.nix
    ./tmux
  ];

  options.dot.shell = {
    preferred = lib.mkOption {
      type = lib.types.enum ["zsh" "bash"];
      default = "zsh";
      description = "Preferred interactive shell.";
    };

    bash.enable = lib.mkEnableOption "Enable bash configuration" // { default = true; };

    zsh.enable = lib.mkEnableOption "Enable zsh configuration" // { default = true; };

    starship.enable = lib.mkEnableOption "starship prompt" // { default = true; };

    devenv.enable = lib.mkEnableOption "Enable devenv" // { default = true; };

    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra aliases to add via dot.shell.";
      example = lib.literalExpression ''
        {
          ll = "ls -la";
          gs = "git status";
        }
      '';
    };
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = cfg.bash.enable || cfg.zsh.enable;
          message = "dot.shell is imported, but both dot.shell.bash.enable and dot.shell.zsh.enable are false.";
        }
        {
          assertion = (cfg.preferred != "bash") || cfg.bash.enable;
          message = "dot.shell.preferred is set to bash, but dot.shell.bash.enable is false.";
        }
        {
          assertion = (cfg.preferred != "zsh") || cfg.zsh.enable;
          message = "dot.shell.preferred is set to zsh, but dot.shell.zsh.enable is false.";
        }
      ];
    }
    {
      home.packages = with pkgs; [
        onefetch
        killall
        alejandra
      ] ++ (
        if config.dot.shell.devenv.enable
        then [pkgs.devenv]
        else []
      );

      dot.shell.aliases = defaultAliases;

      programs.bash = {
        enable = cfg.bash.enable;
        enableCompletion = true;
      };

      programs.zsh.enable = cfg.zsh.enable;

      programs.bash.shellAliases = lib.mkIf cfg.bash.enable cfg.aliases;
      programs.zsh.shellAliases = lib.mkIf cfg.zsh.enable cfg.aliases;
      programs.fish.shellAliases = cfg.aliases;

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = cfg.zsh.enable;
        enableBashIntegration = cfg.bash.enable;
        silent = true;
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = cfg.zsh.enable;
        enableBashIntegration = cfg.bash.enable;
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = cfg.zsh.enable;
        enableBashIntegration = cfg.bash.enable;
      };
    }
  ];
}
