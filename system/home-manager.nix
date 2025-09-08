{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {inherit inputs;};
  };
}
