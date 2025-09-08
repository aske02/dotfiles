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
              ../hosts/${name}/system.nix
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
