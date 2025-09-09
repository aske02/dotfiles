{
  config,
  pkgs,
  host,
  ...
}: {
  imports = [
    ../config.nix

    ../../system/nix.nix
    ../../system/wsl.nix
    ../../system/user.nix
    ../../system/home-manager.nix
    ../../system/docker.nix
    (import ../../system/util.nix {inherit config pkgs host;})

    ../../system/sops.nix

    ../../system/services/1password-agent.nix
    ../../system/services/tailscale.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "24.05";
}
