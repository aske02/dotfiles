{
  config,
  lib,
  ...
}: let
  cfg = config.dot.shell;
in {
  config = lib.mkIf cfg.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = cfg.zsh.enable;
      enableBashIntegration = cfg.bash.enable;
      settings = {
        aws = {symbol = "  ";};
        buf = {symbol = " ";};
        custom.devenv = {
          description = "Indicate an active devenv environment";
          symbol = "🛠 ";
          when = ''test -n "''${DEVENV_ROOT:-}"'';
          format = "[$symbol devenv]($style) ";
          style = "bold blue";
        };
        custom.nix-shell = {
          description = "Indicate a genuine nix-shell (not devenv)";
          symbol = " ";
          when = ''test -n "''${IN_NIX_SHELL:-}" && test -z "''${DEVENV_ROOT:-}"'';
          format = "[$symbol nix-shell]($style) ";
          style = "bold blue";
        };
        c = {symbol = " ";};
        conda = {symbol = " ";};
        crystal = {symbol = " ";};
        dart = {symbol = " ";};
        directory = {read_only = " 󰌾";};
        docker_context = {symbol = " ";};
        elixir = {symbol = " ";};
        elm = {symbol = " ";};
        fennel = {symbol = " ";};
        fossil_branch = {symbol = " ";};
        git_branch = {symbol = " ";};
        golang = {symbol = " ";};
        guix_shell = {symbol = " ";};
        haskell = {symbol = " ";};
        haxe = {symbol = " ";};
        hg_branch = {symbol = " ";};
        hostname = {ssh_symbol = " ";};
        java = {symbol = " ";};
        julia = {symbol = " ";};
        kotlin = {symbol = " ";};
        lua = {symbol = " ";};
        memory_usage = {symbol = "󰍛 ";};
        meson = {symbol = "󰔷 ";};
        nim = {symbol = "󰆥 ";};
        nix_shell = {
          symbol = " ";
          disabled = true;
        };
        nodejs = {symbol = " ";};
        ocaml = {symbol = " ";};
        os = {
          symbols = {
            Alpaquita = " ";
            Alpine = " ";
            Amazon = " ";
            Android = " ";
            Arch = " ";
            Artix = " ";
            CentOS = " ";
            Debian = " ";
            DragonFly = " ";
            Emscripten = " ";
            EndeavourOS = " ";
            Fedora = " ";
            FreeBSD = " ";
            Garuda = "󰛓 ";
            Gentoo = " ";
            HardenedBSD = "󰞌 ";
            Illumos = "󰈸 ";
            Linux = " ";
            Mabox = " ";
            Macos = " ";
            Manjaro = " ";
            Mariner = " ";
            MidnightBSD = " ";
            Mint = " ";
            NetBSD = " ";
            NixOS = " ";
            OpenBSD = "󰈺 ";
            openSUSE = " ";
            OracleLinux = "󰌷 ";
            Pop = " ";
            Raspbian = " ";
            Redhat = " ";
            RedHatEnterprise = " ";
            Redox = "󰀘 ";
            Solus = "󰠳 ";
            SUSE = " ";
            Ubuntu = " ";
            Unknown = " ";
            Windows = "󰍲 ";
          };
        };
        package = {symbol = "󰏗 ";};
        perl = {symbol = " ";};
        php = {symbol = " ";};
        pijul_channel = {symbol = " ";};
        python = {symbol = " ";};
        rlang = {symbol = "󰟔 ";};
        ruby = {symbol = " ";};
        rust = {symbol = " ";};
        scala = {symbol = " ";};
        swift = {symbol = " ";};
        zig = {symbol = " ";};
      };
    };
  };
}
