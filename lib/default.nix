{nixpkgs, ...}: let
in {
  pkgsFor = system:
    import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

  mkNix = {
    configurations,
    inputs,
  }:
    builtins.mapAttrs (
      name: host:
        nixpkgs.lib.nixosSystem {
          system = host.target;
          modules =
            [
              ../hosts/config.nix

              ../system

              ../hosts/${name}/system.nix

              ({
                config,
                ...
              }: {
                home-manager.users.${config.var.username} = {
                  imports = [
                    ../hosts/config.nix
                    ../home
                    ../hosts/${name}/home.nix
                  ];
                };
              })
            ]
            ++ host.extraModules;
          specialArgs = {
            inherit inputs;
            host = host;
          };
        }
    )
    configurations;
}
