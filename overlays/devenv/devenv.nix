final: prev: {
  devenv = prev.devenv.overrideAttrs (oldAttrs: {
    patches =
      (oldAttrs.patches or [])
      ++ [
        ./prompt_prefix.patch
        ./disable_status_line.patch
      ];
  });
}
