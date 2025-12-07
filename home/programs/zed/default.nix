{pkgs, ...}: {
  home.file.".config/zed/themes/theme.json".source = ./theme.json;

  shellAliases = {
    zed = "zed-editor";
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    extensions = [
      "jetbrains-new-ui-icons"
      "nix"
      "toml"
      "lua"
      "prisma"
      "dockerfile"
    ];
    extraPackages = with pkgs; [
      nixd
      alejandra
    ];
    userSettings = {
      calls.mute_on_join = true;
      diagnostics.inline.enabled = true;
      relative_line_numbers = true;
      minimap.show = "auto";
      soft_wrap = "editor_width";
      hard_tabs = true;
      base_keymap = "VSCode";
      icon_theme = "JetBrains New UI Icons (Dark)";
      ui_font_size = 16;
      theme = {
        mode = "dark";
        light = "Her.";
        dark = "Her.";
      };
      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
        background_coloring = "indent_aware";
      };
      show_whitespaces = "trailing";
      remove_trailing_whitespace_on_save = true;
      prettier.allowed = true;

      features = {
        edit_prediction_provider = "copilot";
      };
      show_edit_predictions = true;
    };
  };
}
