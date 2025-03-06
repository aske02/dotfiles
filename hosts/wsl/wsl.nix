{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/1password-agent.nix
  ];

  system.stateVersion = "24.05";

  programs.nix-ld.enable = true;
  users.defaultUserShell = pkgs.zsh;

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.wslConf.network.generateResolvConf = false;

  # Enable Docker
  virtualisation.docker.enable = true;
  users.users.nixos.extraGroups = ["docker"];

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = ["~."];
    dnsovertls = "false";
  };

  services."1password-agent" = {
    npiperelayPath = "/mnt/c/bin/npiperelay.exe";
  };

  environment.systemPackages = with pkgs; [
    socat
    gcc
    gnumake
  ];
}
