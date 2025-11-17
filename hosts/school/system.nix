{
  config,
  host,
  pkgs,
  ...
}: {
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

    ../../system/vm/hyprland

    ../../system/sops.nix

    ../../system/services/tailscale.nix
    ../../system/services/openssh.nix
    ../../system/services/keyring.nix
    ../../system/services/keyd.nix

    ../../system/programs/1password.nix
    ../../system/programs/steam.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix {inherit config host pkgs;};

  system.stateVersion = "25.05";

  environment.systemPackages = with pkgs; [
    linux-firmware
  ];
}
