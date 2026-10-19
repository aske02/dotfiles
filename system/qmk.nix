{
  config,
  pkgs,
  ...
}: let
  username = config.var.username;
in {
  hardware.keyboard.qmk.enable = true;

  services.udev.packages = with pkgs; [
    via
    qmk-udev-rules
  ];

  users.users.${username}.extraGroups = [ "input" "plugdev" ];
}
