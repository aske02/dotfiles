{pkgs, ...}: {
  imports = [
    ./hardware-config.nix
  ];

  dot.system = {
    features = {
      boot.enable = true;
      audio.enable = true;
      docker.enable = false;
      sops.enable = true;
    };

    programs = {
      onepassword.enable = true;
      steam.enable = false;
    };

    services = {
      tailscale.enable = true;
      openssh.enable = true;
      keyring.enable = true;
      keyd.enable = true;
      upower.enable = true;
    };

    wm = {
      hyprland = {
        enable = true;
      };
    };
  };

  system.stateVersion = "26.11";

  environment.systemPackages = with pkgs; [
    linux-firmware
  ];
}
