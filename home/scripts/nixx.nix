{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  dotfiles = config.var.dotfiles;
  username = config.var.username;

  hosts = import ../../hosts inputs;
  systems = hosts.systems;

  isBuilder = h: h ? buildPriority && h.buildPriority > 0;
  buildersRaw = builtins.filter (h: isBuilder h) (builtins.attrValues systems);
  buildersSorted = lib.sortOn (h: h.buildPriority or 1000) buildersRaw;
  allNames = builtins.concatStringsSep " " (map (h: h.hostname) (builtins.attrValues systems));
  buildNames = builtins.concatStringsSep " " (map (h: h.hostname) buildersSorted);
  thinNames =
    builtins.concatStringsSep " " (map (h: h.hostname)
      (builtins.filter (h: !isBuilder h) (builtins.attrValues systems)));

  nixx = pkgs.writeShellApplication {
    name = "nixx";
    runtimeInputs = with pkgs; [nix-fast-build nix-eval-jobs git];
    text = ''
      set -euo pipefail

      HOSTS=(${allNames})
      BUILDERS=(${buildNames})
      THIN=(${thinNames})
      SSH_USER="${username}"
      DOTFILES="${dotfiles}"

      usage() {
        printf '%s\n' \
          "usage: nixx <command> [host] [flags]" \
          "" \
          "commands:" \
          "  build   [host]  build the toplevel (no activation)" \
          "  rebuild [host]  build + sudo nixos-rebuild switch" \
          "  switch  [host]  alias for rebuild" \
          "  test    [host]  build + sudo nixos-rebuild test" \
          "  all              build every host's toplevel" \
          "" \
          "  host defaults to this machine's hostname" \
          "flags:" \
          "  --builder NAME    build on that builder over the tailnet (ssh-ng)" \
          "  --force-local     allow a thin client to build locally (please dont)" \
          "  -h, --help        show this message"
      }

      in_list() {
        local needle="$1"; shift
        local x
        for x in "$@"; do
          [[ "$x" == "$needle" ]] && return 0
        done
        return 1
      }

      is_thin() { in_list "$1" "''${THIN[@]}"; }

      pick_builder() {
        local b
        for b in "''${BUILDERS[@]}"; do
          if [[ "$b" != "$1" ]]; then printf '%s' "$b"; return 0; fi
        done
        return 1
      }

      build_one() {
        local h="$1" b="''${2-}"
        local store_args=()
        if [[ -n "$b" ]]; then
          store_args=(--store "ssh-ng://''${SSH_USER}@''${b}")
        fi
        echo ":: building ''${h} on ''${b:-local}"
        nix-fast-build --skip-cached --eval-workers 4 "''${store_args[@]}" \
          --flake ".#nixosConfigurations.''${h}.config.system.build.toplevel"
      }

      activate() {
        local h="$1" mode="$2"
        cd "$DOTFILES"
        git add .
        sudo nixos-rebuild "$mode" --flake ".#''${h}"
        git status --short
        cd - >/dev/null
      }

      [[ $# -lt 1 ]] && { usage >&2; exit 1; }

      sub="$1"; shift

      host=""
      builder=""
      force_local=0
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --builder) builder="''${2:?--builder requires a name}"; shift 2 ;;
          --force-local) force_local=1; shift ;;
          -h|--help) usage; exit 0 ;;
          -*) printf 'nixx: unknown flag: %s\n' "$1" >&2; usage >&2; exit 1 ;;
          *) host="$1"; shift ;;
        esac
      done

      case "$sub" in
        build)   mode="build" ;;
        rebuild|switch) mode="switch" ;;
        test)    mode="test" ;;
        all)     mode="all" ;;
        help)    usage; exit 0 ;;
        *) printf 'nixx: unknown command: %s\n' "$sub" >&2; usage >&2; exit 1 ;;
      esac

      if [[ "$mode" == "all" ]]; then
        self="$(hostname)"
        if is_thin "$self" && [[ "$force_local" != 1 ]]; then
          printf "nixx: cannot run \`all\` from a thin client (%s); run it from a build host or pass --force-local\n" "$self" >&2
          exit 1
        fi
        for h in "''${HOSTS[@]}"; do
          if [[ "$h" == "$self" ]]; then
            b=""                                  # build ourselves locally
          elif is_thin "$h"; then
            b="$(pick_builder "$h")" || b=""      # thin -> its builder
          else
            b="$h"                                # builder -> build it on itself
          fi
          if [[ -z "$b" ]] && is_thin "$h"; then
            printf 'nixx: no builder available for %s\n' "$h" >&2
            exit 1
          fi
          build_one "$h" "$b"
        done
        printf 'nixx: all hosts built\n'
        exit 0
      fi

      [[ -n "$host" ]] || host="$(hostname)"

      if ! in_list "$host" "''${HOSTS[@]}"; then
        printf 'nixx: unknown host: %s\n' "$host" >&2
        exit 1
      fi
      if [[ -n "$builder" ]] && ! in_list "$builder" "''${BUILDERS[@]}"; then
        printf 'nixx: %s is not a build host\n' "$builder" >&2
        exit 1
      fi

      # Fat-finger guard: thin clients shouldnt build locally.
      if is_thin "$host" && [[ "$force_local" != 1 ]]; then
        [[ -z "$builder" ]] && builder="$(pick_builder "$host")" || builder=""
        if [[ -z "$builder" ]]; then
          printf 'nixx: no builder available for %s; use --builder or --force-local\n' "$host" >&2
          exit 1
        fi
      fi
      if is_thin "$host" && [[ "$builder" == "$host" ]]; then
        printf 'nixx: %s cannot be its own builder\n' "$host" >&2
        exit 1
      fi

      build_one "$host" "$builder"
      if [[ "$mode" != "build" ]]; then
        activate "$host" "$mode"
      fi
    '';
  };
in {
  home.packages = [nixx];
}
