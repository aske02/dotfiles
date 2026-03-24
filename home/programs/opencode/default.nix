{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dot.programs.opencode;
  system = pkgs.stdenv.hostPlatform.system;
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

      env = lib.mkOption {
        type = with lib.types; attrsOf str;
        default = {};
        description = "Environment variables for Plannotator runtime";
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

      soundOnly = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Force notifier to run with sound enabled and notifications disabled";
      };

      volumes = {
        permission = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
          description = "Volume for permission sound (0-1)";
        };

        complete = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
          description = "Volume for completion sound (0-1)";
        };

        error = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
          description = "Volume for error sound (0-1)";
        };

        question = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
          description = "Volume for question sound (0-1)";
        };

        subagent_complete = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
          description = "Volume for subagent completion sound (0-1)";
        };
      };

      settings = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "Extra settings merged into opencode-notifier.json";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;
      package = inputs.opencode.packages.${system}.default;
      settings =
        lib.recursiveUpdate (import ./settings.nix {}) cfg.extraSettings;
    };
  };
}
