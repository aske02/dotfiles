{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.scripts.hyprdynamicmonitorsTui;

  hdmTui = pkgs.writeShellScriptBin "hdm-tui" ''
    set -euo pipefail

    state_dir="$HOME/.local/state/hyprdynamicmonitors/ad-hoc"
    managed_dir="$HOME/.config/hyprdynamicmonitors"

    mkdir -p "$state_dir/hyprconfigs"

    seed() {
      cp "$managed_dir/config.toml" "$state_dir/config.toml"
      cp "$managed_dir"/*.template "$state_dir/" 2>/dev/null || true
      cp "$managed_dir"/*.go.tmpl "$state_dir/hyprconfigs/" 2>/dev/null || true
    }

    reset=false
    if [ "''${1-}" = "--reset" ]; then
      reset=true
      shift
    fi

    if [ ! -f "$managed_dir/config.toml" ]; then
      printf 'Managed config not found at %s\n' "$managed_dir/config.toml" >&2
      exit 1
    fi

    if [ "$reset" = true ] || [ ! -f "$state_dir/config.toml" ]; then
      seed
    fi

    exec hyprdynamicmonitors --config "$state_dir/config.toml" tui "$@"
  '';

  hdmTuiReset = pkgs.writeShellScriptBin "hdm-tui-reset" ''
    set -euo pipefail

    state_dir="$HOME/.local/state/hyprdynamicmonitors/ad-hoc"
    managed_dir="$HOME/.config/hyprdynamicmonitors"

    if [ ! -f "$managed_dir/config.toml" ]; then
      printf 'Managed config not found at %s\n' "$managed_dir/config.toml" >&2
      exit 1
    fi

    rm -rf "$state_dir"
    mkdir -p "$state_dir/hyprconfigs"
    cp "$managed_dir/config.toml" "$state_dir/config.toml"
    cp "$managed_dir"/*.template "$state_dir/" 2>/dev/null || true
    cp "$managed_dir"/*.go.tmpl "$state_dir/hyprconfigs/" 2>/dev/null || true

    printf 'Reset ad-hoc config at %s\n' "$state_dir"
  '';
in {
  options.dot.scripts.hyprdynamicmonitorsTui.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable writable HyprDynamicMonitors TUI helper scripts.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      hdmTui
      hdmTuiReset
    ];
  };
}
