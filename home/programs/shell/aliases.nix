{
  config,
  lib,
  ...
}: {
  options.shellAliases = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    description = "Shell aliases that will be applied to all shells (bash, zsh, fish, etc.)";
    example = lib.literalExpression ''
      {
        ll = "ls -la";
        gs = "git status";
      }
    '';
  };

  config = {
    programs.bash.shellAliases = config.shellAliases;
    programs.zsh.shellAliases = config.shellAliases;
    programs.fish.shellAliases = config.shellAliases;
  };
}
