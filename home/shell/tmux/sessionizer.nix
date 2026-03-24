{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.shell.tmux;
  tsess = pkgs.writeShellScriptBin "tsess" (
    let
      script = ''
        get_sessions() {
          tmux list-sessions -F '[session] #{session_name}' 2>/dev/null
        }

        get_repos() {
          find . -maxdepth 5 -name .git -type d -printf '%h\n' 2>/dev/null | \
            while read -r repo; do
              printf '[repo] %s\n' "$repo"
            done
        }

        sanitize_session_name() {
          local raw_name="$1"
          local safe_name

          safe_name=$(printf '%s' "$raw_name" | tr -c '[:alnum:]_-' '_' | tr -s '_')
          safe_name="''${safe_name#_}"

          if [[ -z "$safe_name" ]]; then
            safe_name="session"
          fi

          printf '%s\n' "$safe_name"
        }

        get_repo_path_for_session() {
          local session_name="$1"
          tmux show-options -t "$session_name" -vq @tsess_repo_path 2>/dev/null
        }

        repo_session_name() {
          local repo_path="$1"
          local base_name
          local existing_path
          local suffix
          local candidate

          base_name=$(sanitize_session_name "$(basename "$repo_path")")

          if tmux has-session -t="$base_name" 2>/dev/null; then
            existing_path=$(get_repo_path_for_session "$base_name")
            if [[ -z "$existing_path" || "$existing_path" == "$repo_path" ]]; then
              printf '%s\n' "$base_name"
              return 0
            fi
          else
            printf '%s\n' "$base_name"
            return 0
          fi

          suffix=$(printf '%s' "$repo_path" | cksum | cut -d' ' -f1)
          candidate="''${base_name}_''${suffix:0:6}"

          while tmux has-session -t="$candidate" 2>/dev/null; do
            existing_path=$(get_repo_path_for_session "$candidate")
            if [[ -z "$existing_path" || "$existing_path" == "$repo_path" ]]; then
              printf '%s\n' "$candidate"
              return 0
            fi
            candidate="''${candidate}_x"
          done

          printf '%s\n' "$candidate"
        }

        main() {
          local selected
          selected=$( (get_sessions; get_repos) | fzf --height=~50% --prompt='Select: ' )

          if [[ -z "$selected" ]]; then
            return 0
          fi

          if [[ "$selected" =~ ^\[session\]\ (.*)$ ]]; then
            local session_name="''${BASH_REMATCH[1]}"
            if [[ -n "$TMUX" ]]; then
              tmux switch-client -t "$session_name"
            else
              tmux attach-session -t "$session_name"
            fi
          elif [[ "$selected" =~ ^\[repo\]\ (.*)$ ]]; then
            local repo_path="''${BASH_REMATCH[1]}"
            local repo_name
            repo_name=$(repo_session_name "$repo_path")

            if tmux has-session -t="$repo_name" 2>/dev/null; then
              if [[ -n "$TMUX" ]]; then
                tmux switch-client -t "$repo_name"
              else
                tmux attach-session -t "$repo_name"
              fi
            else
              tmux new-session -ds "$repo_name" -c "$repo_path"
              tmux set-option -t "$repo_name" @tsess_repo_path "$repo_path" >/dev/null
              if [[ -n "$TMUX" ]]; then
                tmux switch-client -t "$repo_name"
              else
                tmux attach-session -t "$repo_name"
              fi
            fi
          fi
        }

        main
      '';
    in
      script
  );
in {
  config = lib.mkIf (cfg.enable && cfg.sessionizer.enable) {
    home.packages = with pkgs; [
      fzf
      tsess
    ];
  };
}
