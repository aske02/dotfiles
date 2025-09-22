{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        "leftcontrol+leftalt" = "layer(altgr)";
      };
    };
  };
}
