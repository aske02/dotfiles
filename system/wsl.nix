{config, ...}: {
  programs.nix-ld.enable = true;

  networking.networkmanager.enable = false;

  wsl.enable = true;
  wsl.defaultUser = config.var.username;
  wsl.wslConf.network.generateResolvConf = false;

  services.resolved = {
    enable = true;
    settings.Resolve = {
      Domains = ["~."];
      DNSSEC = "false";
      DNSOverTLS = "false";
    };
  };
}
