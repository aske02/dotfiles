{inputs, ...}: {
  local = {
    root = ./.;
    enableAll = true;
  };

  anthropic = {
    root = inputs.skills-catalog.anthropic;
    enableAll = false;
    skills = ["skill-creator"];
  };
}
