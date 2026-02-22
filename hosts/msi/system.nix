{
  config,
  host,
  pkgs,
  ...
}: {
  imports = [
    ../config.nix

    ./hardware-config.nix

    ../../system
  ];

  dot.system = {
    features = {
      boot.enable = true;
      audio.enable = true;
      docker.enable = true;
      sops.enable = true;
    };

    programs.onepassword.enable = true;

    services = {
      tailscale.enable = true;
      openssh.enable = true;
    };

    wm = {
      hyprland = {
        enable = true;
        nvidiaPrime.enable = true;
        nvidiaPrime.intelBusId = "PCI:0:2:0";
        nvidiaPrime.nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  home-manager.users."${config.var.username}" = import ./home.nix {inherit config host pkgs;};

  system.stateVersion = "25.05";
}
