{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixos-wsl,
    nixpkgs,
    home-manager,
    sops-nix,
  }: {
    # Build nixosConfigurations using:
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          sops-nix.nixosModules.sops
          ./hosts/system.nix
          ./hosts/wsl/wsl.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nixos = import ./hosts/wsl/home.nix;
            };
          }
          ({pkgs, ...}: {
            environment.variables.NIXOS_CONFIG_NAME = "wsl";
          })
        ];
      };

      wsl-school = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          sops-nix.nixosModules.sops
          ./hosts/system.nix
          ./hosts/wsl-school/wsl-school.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nixos = import ./hosts/wsl-school/home.nix;
            };
          }
          ({pkgs, ...}: {
            environment.variables.NIXOS_CONFIG_NAME = "wsl-school";
          })
        ];
      };
    };

    devShells.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
      pkgs.mkShell {
        name = "dotfiles-dev-shell";
        packages = with pkgs; [
          alejandra
          sops
        ];
        shellHook = ''
          cp -r .githooks/* .git/hooks
          chmod +x .git/hooks/*
        '';
      };
  };
}
