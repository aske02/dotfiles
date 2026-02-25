{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dot.programs.opencode;
  opencode = inputs.opencode;
  system = pkgs.stdenv.hostPlatform.system;
in {
  options.dot.programs.opencode.enable = lib.mkEnableOption "OpenCode";

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;
      package = opencode.packages.${system}.default;

      # https://opencode.ai/config.json
      settings = {
        default_agent = "plan";
        share = "disabled";

        formatter = {
          alejandra = {
            command = [
              "alejandra"
              "$FILE"
            ];
            extensions = [".nix"];
          };
        };

        watcher.ignore = [
          ".direnv"
          ".env"
          "*.env"
          "*.env.*"
          "secrets"
          ".ssh"
          ".gnupg"
          ".aws"
          ".docker"
          ".kube"
          ".git"
          "node_modules"
          "dist"
          "build"
          "target"
          ".cache"
        ];

        permission = {
          read = {
            "*" = "allow";
            ".direnv/*" = "deny";
            ".env" = "deny";
            "*.env" = "deny";
            "*.env.*" = "deny";
            ".env.*" = "deny";
            "*.envrc" = "deny";
            "secrets/*" = "deny";
            ".config/*" = "ask";
            ".ssh/*" = "deny";
            ".gnupg/*" = "deny";
            ".aws/*" = "deny";
            ".docker/*" = "deny";
            ".kube/*" = "deny";
            ".git/*" = "deny";
            "node_modules/*" = "deny";
            "dist/*" = "deny";
            "build/*" = "deny";
            "target/*" = "deny";
            ".cache/*" = "deny";
          };

          list = "allow";
          glob = "allow";
          grep = "allow";

          webfetch = "ask";

          external_directory = "ask";

          bash = {
            "*" = "ask";
            "cd *" = "allow";
            "ls*" = "allow";
            "pwd" = "allow";
            "rg *" = "allow";
            "git status*" = "allow";
            "git diff*" = "allow";
            "git log*" = "allow";
            "git add*" = "allow";

            "sudo*" = "deny";
            "doas*" = "deny";

            "nixx*" = "deny";
            "home-manager*" = "deny";
            "nixos-rebuild*" = "deny";

            "git commit*" = "deny";
            "git push*" = "deny";
            "git pull*" = "deny";
            "git fetch*" = "deny";
            "git clone*" = "deny";
            "git restore*" = "deny";
            "git reset*" = "deny";
            "git revert*" = "deny";
            "git cherry-pick*" = "deny";
            "git rebase*" = "deny";
            "git merge*" = "deny";
            "git checkout*" = "deny";
            "git switch*" = "deny";
            "git branch*" = "deny";
            "git tag*" = "deny";
            "git branch -d*" = "deny";
            "git branch -D*" = "deny";
            "git branch --delete*" = "deny";
            "git tag -d*" = "deny";
            "git tag --delete*" = "deny";
          };
        };
      };
    };
  };
}
