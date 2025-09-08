{
  pkgs,
  host,
  ...
}: let
  hostname = host.hostname;
  timeZone = host.timezone;
  defaultLocale = host.locale;
in {
  networking.hostName = hostname;

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  time = {timeZone = timeZone;};
  i18n.defaultLocale = defaultLocale;

  programs.nix-ld.enable = true;

  environment.pathsToLink = ["/share/zsh"];

  environment.systemPackages = with pkgs; [
    nixd

    wget
    curl

    _1password-cli
  ];

  security.sudo.wheelNeedsPassword = false;
}
