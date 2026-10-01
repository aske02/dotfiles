{pkgs, ...}: {
  imports = [
    ./hardware-config.nix

    ../../system/audio.nix
    ../../system/boot.nix
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

  system.stateVersion = "26.11";

  environment.systemPackages = with pkgs; [
    linux-firmware
  ];
}
