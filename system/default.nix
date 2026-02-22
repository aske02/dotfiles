{...}: {
  imports = [
    ./nix.nix
    ./util.nix
    ./user.nix
    ./home-manager.nix

    ./boot.nix
    ./audio.nix
    ./docker.nix
    ./sops.nix

    ./programs
    ./services
    ./wm
  ];
}
