{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixos-wsl, nixpkgs, home-manager }:
  {
    # homeConfigurations = {
    #   "Felixs-MacBook-Air" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    #     modules = [
    #       ./hosts/home.nix
    #       ./hosts/darwin/home.nix
    #     ];
    #   };

    #   wsl = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #     modules = [
    #       ./hosts/home.nix
    #       #./hosts/wsl/home.nix
    #     ];
    #   };
    # };

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#personal
    darwinConfigurations."Felixs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/system.nix
        ./hosts/darwin/darwin.nix
        home-manager.darwinModules.home-manager {
          home-manager = {
            # include the home-manager module
            users."felix.berger" = {
              imports = [
                ./hosts/home.nix
                ./hosts/darwin/home.nix
              ];
            }
          };
        }
      ];
    };

    # Build nixosConfigurations using:
    #
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/system.nix
          ./hosts/wsl/wsl.nix
        ];
      };
    };

    darwinPackages = self.darwinConfigurations."personal".pkgs;
  };
}
