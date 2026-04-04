{
  description = "Pinned remote skill sources for OpenCode";

  inputs = {
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
  };

  outputs = inputs: {
    anthropic = inputs.anthropic-skills + "/skills";
  };
}
