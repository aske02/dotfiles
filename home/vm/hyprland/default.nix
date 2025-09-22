{
  config,
  host,
  pkgs,
  ...
}: {
  imports = [
    ./caelestia
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.sourceFirst = true;
  wayland.windowManager.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;

  wayland.windowManager.hyprland.settings = {
    "$terminal" = config.var.terminal;
    "$browser" = config.var.browser;
    "$editor" = config.var.editor;

    "$cursorTheme" = "Bibata-Modern-Ice";
    "$cursorSize" = "36";

    "exec-once" = [
      "caelestia shell -d"
      "caelestia resizer -d"
    ];

    exec = [
      "hyprctl setcursor $cursorTheme $cursorSize"

      "~/.config/hypr/monitor-switch.sh"
    ];

    source = [
      "~/.config/hypr/scheme/current.conf"
      "~/.config/hypr/submap-binds.conf"
    ];

    bind = [
      # Caelestia
      "SUPER, A, global, caelestia:launcher"
      "SUPER, L, global, caelestia:lock"
      "Ctrl+Alt, Delete, global, caelestia:session"
      "SUPER, K, global, caelestia:showall"

      # App launchers
      "SUPER, RETURN, exec, app2unit -- $terminal"
      "SUPER, B, exec, app2unit -- $browser"
      "SUPER, C, exec, app2unit -- $editor"

      # Window management
      "SUPER, Q, killactive"
      "SUPER, F, fullscreen"
      "SUPER, SPACE, togglefloating"

      # Move focus
      "Alt, W, movefocus, l"
      "Alt, S, movefocus, d"
      "Alt, A, movefocus, u"
      "Alt, D, movefocus, r"

      # Move Windows
      "Alt+Shift, W, movewindow, l"
      "Alt+Shift, S, movewindow, d"
      "Alt+Shift, A, movewindow, u"
      "Alt+Shift, D, movewindow, r"

      # Workspace switch
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"

      # Workspace switch (next/prev)
      "SUPER, mouse_down, workspace, next"
      "SUPER, mouse_up, workspace, prev"
      "SUPER+Ctrl, right, workspace, next"
      "SUPER+Ctrl, left, workspace, prev"

      # Move window to workspace
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"

      # Move window to workspace (next/prev)
      "SUPER SHIFT, mouse_down, movetoworkspace, next"
      "SUPER SHIFT, mouse_up, movetoworkspace, prev"
      "SUPER+Ctrl SHIFT, right, movetoworkspace, next"
      "SUPER+Ctrl SHIFT, left, movetoworkspace, prev"

      # Screenshots
      "SUPER, S, exec, caelestia screenshot"

      # Special workspaces
      "SUPER, m, exec, caelestia toggle music"

      # Monitor change
      "SUPER, F10, exec, ~/.config/hypr/monitor-switch.sh"
    ];

    bindin = [
      "SUPER+Alt, L, exec, caelestia shell -d"
    ];

    bindr = [
      "Ctrl+SUPER+Shift, R, exec, qs -c caelestia kill"
      "Ctrl+SUPER+Alt, R, exec, qs -c caelestia kill; caelestia shell -d"
    ];

    input = {
      kb_layout = host.kb_layout;

      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
      };
    };

    general = {
      allow_tearing = false;
    };

    binds = {
      workspace_back_and_forth = true;
      allow_workspace_cycles = true;
      pass_mouse_when_bound = false;
    };

    misc = {
      vfr = true;
      vrr = 1;

      disable_hyprland_logo = true;
      force_default_wallpaper = 0;

      new_window_takes_over_fullscreen = 2;
      allow_session_lock_restore = true;
      middle_click_paste = false;
      focus_on_activate = true;
      session_lock_xray = true;

      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;

      background_color = "rgb($surfaceContainer)";
    };

    animations = {
      enabled = true;

      bezier = [
        "specialWorkSwitch, 0.05, 0.7, 0.1, 1"
        "emphasizedAccel, 0.3, 0, 0.8, 0.15"
        "emphasizedDecel, 0.05, 0.7, 0.1, 1"
        "standard, 0.2, 0, 0, 1"
      ];

      animation = [
        "layersIn, 1, 5, emphasizedDecel, slide"
        "layersOut, 1, 4, emphasizedAccel, slide"
        "fadeLayers, 1, 5, standard"
        "windowsIn, 1, 5, emphasizedDecel"
        "windowsOut, 1, 3, emphasizedAccel"
        "windowsMove, 1, 6, standard"
        "workspaces, 1, 5, standard"
        "specialWorkspace, 1, 4, specialWorkSwitch, slidefadevert 15%"
        "fade, 1, 6, standard"
        "fadeDim, 1, 6, standard"
        "border, 1, 6, standard"
      ];
    };

    group = {
      "col.border_active" = "rgba($primarye6)";
      "col.border_inactive" = "rgba($onSurfaceVariant11)";
      "col.border_locked_active" = "rgba($primarye6)";
      "col.border_locked_inactive" = "rgba($onSurfaceVariant11)";

      groupbar = {
        font_family = "JetBrains Mono NF";
        font_size = 15;
        gradients = true;
        gradient_round_only_edges = false;
        gradient_rounding = 5;
        height = 25;
        indicator_height = 0;
        gaps_in = 3;
        gaps_out = 3;

        text_color = "rgb($onPrimary)";
        "col.active" = "rgba($primaryd4)";
        "col.inactive" = "rgba($outlined4)";
        "col.locked_active" = "rgba($primaryd4)";
        "col.locked_inactive" = "rgba($secondaryd4)";
      };
    };

    env = [
      "XDG_CURRENT_DESKTOP=Hyprland"
      "XDG_SESSION_TYPE=wayland"
      "XDG_SESSION_DESKTOP=Hyprland"

      "QT_QPA_PLATFORMTHEME=qt5ct"
      "QT_STYLE_OVERRIDE=kvantum"

      "XCURSOR_THEME=$cursorTheme"
      "XCURSOR_SIZE=$cursorSize"
      "GTK_CursorThemeName=$cursorTheme"
      "GTK_CursorThemeSize=$cursorSize"
    ];
  };

  home.file.".config/hypr/submap-binds.conf".text = ''
    exec-once = hyprctl dispatch submap global
    submap = global

    bindin = SUPER, catchall, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse:272, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse:273, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse:274, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse:275, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse:276, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse:277, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse_up, global, caelestia:launcherInterrupt
    bindin = SUPER, mouse_down, global, caelestia:launcherInterrupt
  '';

  home.file.".config/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=$cursorTheme
    gtk-cursor-theme-size=$cursorSize
  '';

  home.file.".config/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=$cursorTheme
    gtk-cursor-theme-size=$cursorSize
  '';
}
