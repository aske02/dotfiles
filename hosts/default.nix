{
  home-manager,
  nixos-wsl,
  ...
}: rec {
  base = {
    timezone = "Europe/Copenhagen";
    locale = "en_DK.UTF-8";
    kb_layout = "dk";
  };

  systems = rec {
    wsl =
      base
      // {
        target = "x86_64-linux";
        config = "wsl";
        hostname = "wsl";
        buildPriority = 1;
        extraModules = [
          home-manager.nixosModules.home-manager
          nixos-wsl.nixosModules.wsl
        ];
      };

    wsl-school =
      base
      // {
        target = wsl.target;
        config = "wsl-school";
        hostname = "wsl-school";
        buildPriority = 4;
        extraModules = wsl.extraModules;
      };

    school =
      base
      // {
        target = "x86_64-linux";
        config = "school";
        hostname = "school";
        buildPriority = 3;
        extraModules = [
          home-manager.nixosModules.home-manager
        ];
      };

    msi =
      base
      // {
        target = "x86_64-linux";
        config = "msi";
        hostname = "msi";
        buildPriority = 2;
        extraModules = [
          home-manager.nixosModules.home-manager
        ];
      };

    think =
      base
      // {
        target = "x86_64-linux";
        config = "think";
        hostname = "think";
        buildPriority = 0;
        extraModules = [
          home-manager.nixosModules.home-manager
        ];
      };
  };
}
