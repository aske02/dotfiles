{config, ...}: {
  imports = [
    ../config.nix

    ../../system/nix.nix
    ../../system/wsl.nix
    ../../system/user.nix
    ../../system/home-manager.nix
    ../../system/docker.nix
    ../../system/util.nix

    ../../system/sops.nix

    ../../system/services/1password-agent.nix
    ../../system/services/tailscale.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "24.05";
}
