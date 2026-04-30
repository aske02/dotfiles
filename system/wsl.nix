{
  config,
  lib,
  ...
}: {
  programs.nix-ld.enable = true;

  networking.networkmanager.enable = false;

  wsl.enable = true;
  wsl.defaultUser = config.var.username;
  wsl.wslConf.network.generateResolvConf = false;

  networking.resolvconf.enable = lib.mkForce false;

  # Remote server utils in WSL doesnt open interactive shells, so we need to force a link rule for cp
  # Zed extension remote uses cp to copy recompiled extensions over this way
  systemd.tmpfiles.rules = [
    "L+ /bin/cp - - - - /run/current-system/sw/bin/cp"
  ];

  services.resolved = {
    enable = true;
    settings.Resolve = {
      Domains = ["~."];
      DNSSEC = "false";
      DNSOverTLS = "false";
    };
  };
}
