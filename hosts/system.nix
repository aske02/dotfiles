{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    zsh
    wget
    home-manager
    git
    fzf
    _1password-cli
    starship
  ];

  sops.defaultSopsFile = ../secrets/secrets.enc.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "home/nixos/.config/sops/keys.txt";
}
