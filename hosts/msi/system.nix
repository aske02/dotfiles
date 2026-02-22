{
  config,
  host,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-config.nix
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

  system.stateVersion = "25.05";
}
