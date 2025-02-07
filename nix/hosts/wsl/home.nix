{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
  ];
  
  home.file = {
    ".ssh_pipe".source = ../../../zsh/.ssh_pipe;
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  programs.git = {
    enable = true;
    
    userName = "Aske";
    userEmail = "aske020304@gmail.com";

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBuGWVW12wKcCYaHAZABfS3opkJlf/JC9Yo3xMRq6wyp";
    };

    extraConfig = {
      github.user = "aske02";
      core.sshCommand = "ssh.exe";
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      gpg.ssh.program = "/mnt/c/Users/aske0/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
      commit.gpgSign = true;
    };
  };

  programs.zsh = {
	initExtra = ''
		source ~/.ssh_pipe
	'';
  };
}
