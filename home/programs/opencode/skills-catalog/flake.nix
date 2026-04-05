{
  description = "Pinned remote skill sources for OpenCode";

  inputs = {
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };

    vercel-skills = {
      url = "github:vercel-labs/agent-skills";
      flake = false;
    };
  };

  outputs = inputs: {
    anthropic = inputs.anthropic-skills + "/skills";
    vercel = inputs.vercel-skills + "/skills";
  };
}
