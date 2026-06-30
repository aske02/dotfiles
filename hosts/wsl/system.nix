{pkgs, ...}: {
  imports = [
    ../../system/wsl.nix
  ];

  environment.systemPackages = [pkgs.ghostty.terminfo];
  environment.pathsToLink = ["/share/terminfo"];

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
