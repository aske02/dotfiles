{pkgs, ...}: {
  imports = [
    ../../system/docker.nix
    ../../system/home-manager.nix
    ../../system/nix.nix
    ../../system/sops.nix
    ../../system/user.nix
    ../../system/util.nix
    ../../system/wsl.nix

    ../../system/services/1password-agent.nix
    ../../system/services/openssh.nix
    ../../system/services/tailscale.nix
  ];

  environment.systemPackages = [pkgs.ghostty.terminfo];
  environment.pathsToLink = ["/share/terminfo"];

  system.stateVersion = "24.05";
}
