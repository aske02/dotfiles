{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.ssh.enable {
    programs.ssh.extraConfig = ''
      Host wsl wsl-school

      Host *
          SetEnv TERM=xterm-256color
    '';
  };
}
