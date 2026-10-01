{pkgs, ...}: {
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  environment.systemPackages = [
    pkgs._1password-cli
  ];
}
