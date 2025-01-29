{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      services.nix-daemon.enable = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.zed-editor
        pkgs.nixd
        pkgs.nil
        pkgs.git
        pkgs.gh
        pkgs.starship
        pkgs.raycast
        pkgs.tmux
        pkgs.fzf
        pkgs.spotify
      ];

      # Fonts
      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      #homebrew
      homebrew = {
        enable = true;
        casks = [
          "1password"
          "discord"
          "arc"
          "docker"
          "notion"
        ];
        onActivation = {
          autoUpdate = true;
          cleanup = "uninstall";
          upgrade = true;
        };
        brews = [
          "pyenv"
        ];
      };

      #Users
      users.users = {
        "felix.berger" = {
          name = "felix.berger";
          home = "/Users/felix.berger";
        };
      };
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;


      system.defaults = {
        dock.autohide = true;
        dock.tilesize = 48;
        dock.magnification = false;
        dock.persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Arc.app"
          "/Applications/Discord.app"
          "/Applications/Ghostty.app"
          "${pkgs.zed-editor}/Applications/Zed.app"
          "/System/Applications/System Settings.app"
        ];

        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";

        trackpad.TrackpadRightClick = true;

        controlcenter.BatteryShowPercentage = true;

        NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
      };


      # Enable sudo touch id authentication
      security.pam.enableSudoTouchIdAuth = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#personal
    darwinConfigurations."Felixs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."felix.berger" = import ./home.nix;
          };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."personal".pkgs;
  };
}
