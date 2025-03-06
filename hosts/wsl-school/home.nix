{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../../modules/git.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  programs.git.extraConfig.core.sshCommand = "ssh.exe";
  programs.git.extraConfig.gpg.ssh.program = "/mnt/c/Users/66594/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
}
