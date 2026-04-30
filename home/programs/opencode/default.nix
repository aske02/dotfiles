{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dot.programs.opencode;
  system = pkgs.stdenv.system;
  opencode_pkg = inputs.auxera-pkgs.packages.${system}.opencode;
in {
  imports = [
    ./plugins
  ];

  options.dot.programs.opencode = {
    enable = lib.mkEnableOption "OpenCode";

    extraSettings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Extra OpenCode settings merged into defaults";
    };

    addons.plannotator = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Install source-built Plannotator plugin and commands";
      };
    };

    addons.notifier = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Install source-built OpenCode notifier plugin";
      };

      sound = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable notifier sounds by default";
      };

      notification = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable notifier desktop notifications by default";
      };
    };

    addons.skills = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Install OpenCode skills into the config directory";
      };

      sources = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule ({...}: {
          options = {
            root = lib.mkOption {
              type = lib.types.path;
              description = "Root directory that contains skill directories with SKILL.md files";
            };

            enableAll = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Install all valid skills from this source";
            };

            skills = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [];
              description = "Specific skills to install from this source";
            };
          };

          config = {
            root = lib.mkDefault ./skills;
          };
        }));
        default = import ./skills {inherit inputs;};
        description = "Skill sources to expose to OpenCode agents";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;
      package = opencode_pkg;
      settings =
        lib.recursiveUpdate (import ./settings.nix {}) cfg.extraSettings;
    };
  };
}
