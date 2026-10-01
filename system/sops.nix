{config, ...}: {
  sops.defaultSopsFile = ../secrets/secrets.enc.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "home/" + config.var.username + "/.config/sops/keys.txt";
}
