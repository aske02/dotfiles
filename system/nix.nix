{...}: {
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    permittedInsecurePackages = [
      "beekeeper-studio-5.5.5"
    ];
  };

  nix = {
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      download-buffer-size = 209715200; # 200 MiB
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
