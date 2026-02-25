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
            repo_name=$(basename "$repo_path")

            if tmux has-session -t="$repo_name" 2>/dev/null; then
              if [[ -n "$TMUX" ]]; then
                tmux switch-client -t "$repo_name"
              else
                tmux attach-session -t "$repo_name"
              fi
            else
              tmux new-session -ds "$repo_name" -c "$repo_path"
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
