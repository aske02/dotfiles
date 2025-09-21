{
  home-manager,
  sops-nix,
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
        extraModules = [
          sops-nix.nixosModules.sops
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
        extraModules = wsl.extraModules;
      };

    school =
      base
      // {
        target = "x86_64-linux";
        config = "school";
        hostname = "school";
        extraModules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
        ];
      };

    msi =
      base
      // {
        target = "x86_64-linux";
        config = "msi";
        hostname = "msi";
        extraModules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
        ];
      };
  };
}
