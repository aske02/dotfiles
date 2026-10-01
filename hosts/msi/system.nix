{...}: {
  imports = [
    ./hardware-config.nix

    ../../system/audio.nix
    ../../system/boot.nix
    ../../system/docker.nix
    ../../system/home-manager.nix
    ../../system/nix.nix
    ../../system/user.nix
    ../../system/util.nix

    ../../system/wm/hyprland

    ../../system/services/tailscale.nix
    ../../system/services/openssh.nix
    ../../system/services/keyring.nix
    ../../system/services/keyd.nix
    ../../system/services/misc.nix

    ../../system/programs/1password.nix
  ];

  dot.system.wm.hyprland = {
    nvidiaPrime.enable = true;
    nvidiaPrime.intelBusId = "PCI:0:2:0";
    nvidiaPrime.nvidiaBusId = "PCI:1:0:0";
  };

  system.stateVersion = "25.05";
}
