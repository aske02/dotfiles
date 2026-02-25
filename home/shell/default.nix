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
    ./tmux
  ];

  options.dot.shell = {
    enable = lib.mkEnableOption "Shell tooling";

    preferred = lib.mkOption {
      type = lib.types.enum ["zsh" "bash"];
      default = "zsh";
      description = "Preferred interactive shell.";
    };

    bash.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable bash configuration.";
    };

    zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zsh configuration.";
    };

    starship.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable starship prompt.";
    };

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
      assertions = lib.optionals cfg.enable [
        {
          assertion = cfg.bash.enable || cfg.zsh.enable;
          message = "dot.shell.enable is true, but both dot.shell.bash.enable and dot.shell.zsh.enable are false.";
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

    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        onefetch
        killall
        alejandra
      ];

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
    })
  ];
}
