{
  inputs,
  pkgs,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = [
    inputs.hyprdynamicmonitors.packages.${system}.default
  ];

  imports = [
    inputs.hyprdynamicmonitors.homeManagerModules.default
  ];

  home.hyprdynamicmonitors = {
    enable = true;
    configFile = tomlFormat.generate "config" {
      debounce_time_ms = 500;
      post_apply_exec = "sleep 1; caelestia shell -k; sleep 1; caelestia shell -d;";
      notifications = {
        timeout_ms = 3000;
      };
      profiles = {
        # Profiles ordering is used as priority, last matching is applied
        "1_laptop_only" = {
          config_file = "laptop_only.template";
          config_file_type = "template";
          conditions.required_monitors = [
            {
              name = "DP-.*";
              match_name_using_regex = true;
              monitor_tag = "internal";
            }
          ];
        };
        "2_extern_only" = {
          config_file = "extern_only.template";
          config_file_type = "template";
          conditions.required_monitors = [
            {
              name = "HDMI-.*";
              match_name_using_regex = true;
              monitor_tag = "external";
            }
            {
              name = "DP-.*";
              match_name_using_regex = true;
              monitor_tag = "internal";
            }
          ];
        };
      };
    };
  };

  home.file.".config/hyprdynamicmonitors/laptop_only.template".text = ''
    {{- $internal := index .MonitorsByTag "internal" -}}
    monitor={{$internal.Name}},1920x1080@60,0x0, 1
  '';

  home.file.".config/hyprdynamicmonitors/extern_only.template".text = ''
    {{- $external := index .MonitorsByTag "external" -}}
    {{- $internal := index .MonitorsByTag "internal" -}}
    monitor={{$external.Name}},1920x1080@60,0x0, 1
    monitor={{$internal.Name}},disable
  '';
}
