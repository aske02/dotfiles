{...}: {
  imports = [
    ../../system/wsl.nix
  ];

  dot.system = {
    features = {
      docker.enable = true;
      sops.enable = true;
      audio.enable = true;
    };

    services = {
      onepasswordAgent.enable = true;
      tailscale.enable = true;
      openssh.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
