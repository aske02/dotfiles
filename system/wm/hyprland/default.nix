{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.system.wm.hyprland;
in {
  options.dot.system.wm.hyprland = {
    enable = lib.mkEnableOption "Hyprland";

    nvidiaPrime = {
      enable = lib.mkEnableOption "NVIDIA PRIME sync setup";

      intelBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "PCI:0:2:0";
        description = "Intel GPU PCI bus id for PRIME.";
      };

      nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "PCI:1:0:0";
        description = "NVIDIA GPU PCI bus id for PRIME.";
      };
    };
  };

  imports = [
    ./overlay.nix
  ];

  config = lib.mkIf cfg.enable {
    services.greetd.enable = true;
    services.greetd.settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd Hyprland";
        user = config.var.username;
      };
    };

    services.xserver.enable = false;

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal
      qt5.qtwayland
      qt6.qtwayland
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

    services.xserver.videoDrivers = lib.mkIf cfg.nvidiaPrime.enable ["nvidia"];

    hardware.nvidia = lib.mkIf cfg.nvidiaPrime.enable {
      open = false;
      prime = {
        sync.enable = true;
        intelBusId = cfg.nvidiaPrime.intelBusId;
        nvidiaBusId = cfg.nvidiaPrime.nvidiaBusId;
      };
      modesetting.enable = true;
    };
  };
}
