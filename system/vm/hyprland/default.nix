{
  config,
  pkgs,
  ...
}: let
  username = config.var.username;
in {
  imports = [
    ./overlay.nix
  ];

  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --cmd Hyprland";
      user = username;
    };
  };
  services.displayManager.defaultSession = "hyprland";

  services.xserver.enable = false;

  hardware.nvidia.open = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    qt5.qtwayland
    qt6.qtwayland
    capitaine-cursors
    bibata-cursors
    wl-clipboard
    app2unit
    dconf
  ];

  xdg.portal = {
    enable = true;
    config.common.default = ["hyprland"];
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };
}
