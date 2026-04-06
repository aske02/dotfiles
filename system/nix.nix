{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.dot.system.core.nix;
in {
  options.dot.system.core.nix.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable base Nix and nixpkgs settings.";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        "beekeeper-studio-5.5.7"
      ];
    };

    nixpkgs.overlays = [
      inputs.auxera-pkgs.overlays.default
    ];

    nix = {
      extraOptions = ''
        warn-dirty = false
      '';
      settings = {
        download-buffer-size = 209715200; # 200 MiB
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        substituters = ["https://cache.nixos.org" "https://auxera.cachix.org"];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrA3kbhn2flpey849RP97Bh4="
          "auxera.cachix.org-1:47t8ocmmQE2OyAEipk98QQsAqG9GFz+5yQ4Ey1AjIHM="
        ];
      };
      gc = {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
