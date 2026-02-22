{
  config,
  pkgs,
  host,
  lib,
  ...
}: let
  hostname = host.hostname;
  timeZone = host.timezone;
  defaultLocale = host.locale;
  cfg = config.dot.system.core.util;
in {
  options.dot.system.core.util.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable base system utilities and defaults.";
  };

  config = lib.mkIf cfg.enable {
    networking.hostName = hostname;

    networking.networkmanager.enable = lib.mkDefault true;
    systemd.services.NetworkManager-wait-online.enable = false;

    time = {timeZone = timeZone;};
    i18n.defaultLocale = defaultLocale;
    console.keyMap = "dk-latin1";

    programs.nix-ld.enable = true;

    environment.pathsToLink = ["/share/zsh"];

    environment.systemPackages = with pkgs; [
      nixd

      wget
      curl

      libnotify
    ];

    security.sudo.wheelNeedsPassword = false;
  };
}
