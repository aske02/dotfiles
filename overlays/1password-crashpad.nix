final: prev: {
  # nixpkgs' linux.nix for _1password-gui only patchelf's
  # {1password,1Password-BrowserSupport,1Password-LastPass-Exporter,op-ssh-sign}.
  # Since 8.12.x the Electron bundle also ships chrome_crashpad_handler, which is
  # left unpatched: it can't find libglib-2.0.so.0 and segfaults on startup,
  # taking the whole app down with no window and no error output.
  # Patch the interpreter + rpath for it in postInstall as well.
  _1password-gui = prev._1password-gui.overrideAttrs (old: {
    postInstall =
      (old.postInstall or "")
      + ''
        interp="$(cat $NIX_CC/nix-support/dynamic-linker)"
        crashpad="$out/share/1password/chrome_crashpad_handler"
        if [ -f "$crashpad" ]; then
          patchelf --set-interpreter "$interp" "$crashpad"
          patchelf --set-rpath "${prev.lib.makeLibraryPath [prev.glib prev.dbus prev.systemd]}:$out/share/1password" "$crashpad"
        fi
      '';
  });
}
