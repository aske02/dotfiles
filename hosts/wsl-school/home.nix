{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../../modules/git.nix
  ];

  home.file = {
    ".ssh_pipe".source = ../../modules/zsh/.ssh_pipe;
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  programs.git.extraConfig.core.sshCommand = "ssh.exe";
  programs.git.extraConfig.gpg.ssh.program = "/mnt/c/Users/66594/AppData/Local/1Password/app/8/op-ssh-sign-wsl";

  programs.zsh.initExtra = ''
    source ~/.ssh_pipe
  '';

  programs.zsh.shellGlobalAliases = {
    # Temp fix
    ssh = "ssh.exe";
  };
}
