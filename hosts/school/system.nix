{config, ...}: {
  imports = [
    ../config.nix

    ./hardware-config.nix

    ../../system/boot.nix
    ../../system/nix.nix
    ../../system/user.nix
    ../../system/home-manager.nix
    ../../system/docker.nix
    ../../system/util.nix
    ../../system/audio.nix
    ../../system/xserver.nix

    ../../system/sops.nix

    ../../system/services/tailscale.nix
    ../../system/services/openssh.nix

    ../../system/programs/1password.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "24.05";
}
