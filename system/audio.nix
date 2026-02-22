{
  config,
  lib,
  ...
}: let
  cfg = config.dot.system.features.audio;
in {
  options.dot.system.features.audio.enable =
    lib.mkEnableOption "PipeWire audio stack";

  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    security.rtkit.enable = true;
  };
}
