{}: {
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
      ".env.*" = "deny";
      ".env.example" = "allow";
      ".envrc" = "allow";
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

    webfetch = "allow";

    skill = {
      "*" = "allow";
    };

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
      "git pull*" = "ask";
      "git fetch*" = "ask";
      "git clone*" = "ask";
      "git restore*" = "ask";
      "git reset*" = "ask";
      "git revert*" = "ask";
      "git cherry-pick*" = "ask";
      "git rebase*" = "ask";
      "git merge*" = "ask";
      "git checkout*" = "ask";
      "git switch*" = "ask";
      "git branch*" = "ask";
      "git tag*" = "ask";
      "git branch -d*" = "ask";
      "git branch -D*" = "ask";
      "git branch --delete*" = "ask";
      "git tag -d*" = "ask";
      "git tag --delete*" = "ask";
    };
  };
}
