{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dot.shell.tmux;
in {
  config = lib.mkIf (cfg.enable) {
    programs.tmux = {
      enable = true;
      terminal = "screen-256color";
      clock24 = true;
      mouse = true;
      secureSocket = true;
      escapeTime = 0;
      historyLimit = 100000;
      prefix = "C-Space";

      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        catppuccin
      ];

      extraConfig = ''
        set -g status-position top
        set -g status-justify left
        set -g status-left ""
        set -g status-left-length 0
        set -g status-right-length 100
        set -g automatic-rename off
        set -g allow-rename off

        set -g base-index 1
        setw -g pane-base-index 1

        set -as terminal-overrides ",ghostty:Tc,*:RGB"

        set -g pane-border-status off
        set -g set-clipboard on
        set -g allow-passthrough on
        set -g repeat-time 300

        unbind C-Space
        unbind -n C-j
        unbind C-j
        bind C-space send-prefix
        bind r source-file "${config.xdg.configHome}/tmux/tmux.conf" \; display-message "tmux reloaded"
        bind m command-prompt -I "#W" "rename-window '%%'"
        bind q confirm-before -p "kill-window #W? (y/n)" kill-window
        bind n new-window -c "#{pane_current_path}"

        bind -r Left previous-window
        bind -r Right next-window

        set -g @yank_selection 'clipboard'
        set -g @yank_action 'copy-pipe-and-cancel'

        set -g @resurrect-capture-pane-contents 'on'
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '10'

        set -g @catppuccin_flavour 'mocha'
        set -g @catppuccin_window_status_style 'rounded'
        set -g @catppuccin_window_current_style 'rounded'
        set -g @catppuccin_window_text " #W "
        set -g @catppuccin_window_current_text " #W "
        set -g status-right "#{E:@catppuccin_status_application}#{E:@catppuccin_status_session}"
        set -g @catppuccin_window_left_separator "\uE0B6"
        set -g @catppuccin_window_right_separator "\uE0B4"
        set -g @catppuccin_status_left_separator "\uE0B6"
        set -g @catppuccin_status_right_separator "\uE0B4"
        set -g @catppuccin_pane_active_border_style 'fg=#89b4fa'
        set -g @catppuccin_pane_border_style 'fg=#45475a'
        set -g @catppuccin_status_background 'default'
      '';
    };

    home.packages = with pkgs; [
      tmux
    ];
  };
}
