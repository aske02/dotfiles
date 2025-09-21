{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NUR = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = inputs: let
    lib = import ./lib inputs;
    hosts = import ./hosts inputs;
  in
    {
      nixosConfigurations = lib.mkNix {
        configurations = hosts.systems;
        inputs = inputs;
      };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = lib.pkgsFor system;
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            sops
          ];
          shellHook = ''
            cp -r .githooks/* .git/hooks
            chmod +x .git/hooks/*
          '';
        };
      }
    );
}
