{config, ...}: {
  programs.nix-ld.enable = true;

  networking.networkmanager.enable = false;

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
