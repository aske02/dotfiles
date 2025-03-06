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
}
