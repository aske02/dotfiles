{
  config,
  pkgs,
  lib,
  host,
  ...
}: {
  imports = [
    ../config.nix

    ../../system/wsl.nix

    ../../system
  ];

  dot.system = {
    features = {
      docker.enable = true;
      sops.enable = true;
    };

    services = {
      onepasswordAgent.enable = true;
      tailscale.enable = true;
    };
  };

  home-manager.users."${config.var.username}" = import ./home.nix {inherit config host pkgs;};

  system.stateVersion = "24.05";
}
