{
  config,
  lib,
  ...
}: let
  cfg = config.dot.system.services.tailscale;
  username = config.var.username;
in {
  options.dot.system.services.tailscale.enable =
    lib.mkEnableOption "Tailscale";

  config = lib.mkIf cfg.enable {
    security.sudo.extraRules = [
      {
        users = [username];
        commands = [
          {
            command = "/etc/profiles/per-user/${username}/bin/tailscale";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/current-system/sw/bin/tailscale";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];

    services.tailscale = {
      enable = true;
      openFirewall = true;
    };

    networking.firewall = {
      trustedInterfaces = ["tailscale0"];
      checkReversePath = "loose";
    };
  };
}
