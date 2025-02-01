{ config, pkgs, lib, ... }: {
    wsl.enable = true;
    wsl.defaultUser = "nixos";
    wsl.wslConf.network.generateResolvConf = false;

    # Enable Docker
    virtualisation.docker.enable = true;
    users.users.nixos.extraGroups = [ "docker" ];

    services.resolved = {
        enable = true;
        dnssec = "false";
        domains = [ "~." ];
        dnsovertls = "false";
    };
}