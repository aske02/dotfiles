{
  config,
  lib,
  ...
}: {
  config.var = {
    username = "aske";

    dotfiles = "/home/" + config.var.username + "/.dotfiles";

    main_sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBuGWVW12wKcCYaHAZABfS3opkJlf/JC9Yo3xMRq6wyp main";
    sshKeys = [
      config.var.main_sshKey
    ];

    github = {
      username = "aske02";
    };

    npiperelayPath = "/mnt/c/bin/npiperelay.exe";

    terminal = "ghostty";
    browser = "librewolf";
    editor = "code";
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
