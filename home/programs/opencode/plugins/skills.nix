{
  config,
  lib,
  ...
}: let
  cfg = config.dot.programs.opencode;
  skillsCfg = cfg.addons.skills;

  discoveredSkillsForSource = source: let
    entries = builtins.readDir source.root;
    names = builtins.attrNames entries;
  in
    lib.filter (skillName: let
      entryType = entries.${skillName};
      skillDir = source.root + "/${skillName}";
    in
      (entryType == "directory" || entryType == "symlink")
      && builtins.pathExists (skillDir + "/SKILL.md"))
    names;

  selectedSkills =
    lib.concatLists
    (lib.mapAttrsToList (_sourceName: source: let
      sourceSkillNames =
        lib.unique
        ((
            if source.enableAll
            then discoveredSkillsForSource source
            else []
          )
          ++ source.skills);
    in
      map (skillName: {
        inherit skillName;
        skillDir = source.root + "/${skillName}";
        skillFile = source.root + "/${skillName}/SKILL.md";
      })
      sourceSkillNames)
    skillsCfg.sources);

  selectedSkillNames = map (skill: skill.skillName) selectedSkills;

  duplicateSkillNames =
    lib.filter (skillName: lib.count (name: name == skillName) selectedSkillNames > 1)
    (lib.unique selectedSkillNames);

  missingSkillFiles = lib.filter (skill: !(builtins.pathExists skill.skillFile)) selectedSkills;

  skillFiles =
    lib.listToAttrs
    (map (skill:
      lib.nameValuePair "opencode/skills/${skill.skillName}" {
        source = skill.skillDir;
      })
    selectedSkills);
in {
  config = lib.mkIf (cfg.enable && skillsCfg.enable) {
    assertions = [
      {
        assertion = duplicateSkillNames == [];
        message = "OpenCode skill names collide across configured sources: ${lib.concatStringsSep ", " duplicateSkillNames}";
      }
      {
        assertion = missingSkillFiles == [];
        message = "Configured OpenCode skills are missing SKILL.md: ${lib.concatStringsSep ", " (map (skill: skill.skillName) missingSkillFiles)}";
      }
    ];

    xdg.configFile = skillFiles;
  };
}
