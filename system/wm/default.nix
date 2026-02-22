{ config, lib, ... }: {
  imports = [
    ./gnome
    ./hyprland
  ];

  config = {
    assertions = [
      {
        assertion =
          !(
            (config.dot.system.wm.hyprland.enable or false)
            && (config.dot.system.wm.gnome.enable or false)
          );
        message = "Only one of dot.system.wm.hyprland.enable and dot.system.wm.gnome.enable can be enabled.";
      }
    ];
  };
}
