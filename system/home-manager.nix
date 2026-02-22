{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.dot.system.core.homeManager.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable Home Manager integration.";
  };

  config = lib.mkIf config.dot.system.core.homeManager.enable {
    environment.systemPackages = [
      pkgs.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
