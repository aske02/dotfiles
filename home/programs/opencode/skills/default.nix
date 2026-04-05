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

  vercel = {
    root = inputs.skills-catalog.vercel;
    enableAll = false;
    skills = ["react-best-practices" "web-design-guidelines"];
  };
}
