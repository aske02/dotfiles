{config, ...}: {
  programs.nix-ld.enable = true;

  wsl.enable = true;
  wsl.defaultUser = config.var.username;
  wsl.wslConf.network.generateResolvConf = false;

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = ["~."];
    dnsovertls = "false";
  };
}
