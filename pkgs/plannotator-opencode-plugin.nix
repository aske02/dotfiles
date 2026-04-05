{
  lib,
  stdenvNoCC,
  bun,
  nodejs,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "plannotator-opencode-plugin";
  version = "0.16.7";

  src = fetchFromGitHub {
    owner = "backnotprop";
    repo = "plannotator";
    rev = "v0.16.7";
    hash = "sha256-1SHn2QSyuVAuIG7s4/eel6C59iouMTRE72hPIkUzbYo=";
  };

  nativeBuildInputs = [
    bun
    nodejs
  ];

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-mMLSUjh4wsYy8wQQZjUwtEEq5IDyvDmnQPufO6DXyB4=";

  dontFixup = true;

  buildPhase = ''
    runHook preBuild
    set -euxo pipefail

    export HOME="$TMPDIR/home"
    mkdir -p "$HOME"
    export BUN_INSTALL_CACHE_DIR="$TMPDIR/bun-cache"

    bun install --frozen-lockfile --ignore-scripts
    patchShebangs node_modules
    patchShebangs apps/hook/node_modules
    patchShebangs apps/review/node_modules
    patchShebangs apps/opencode-plugin/node_modules

    (
      cd apps/review
      bun x vite build
    )

    (
      cd apps/hook
      bun x vite build
      cp dist/index.html dist/redline.html
      cp ../review/dist/index.html dist/review.html
    )

    (
      cd apps/opencode-plugin
      cp ../hook/dist/index.html ./plannotator.html
      cp ../review/dist/index.html ./review-editor.html
      bun build index.ts --outfile dist/index.js --target bun --packages=bundle
    )

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/plugins"
    mkdir -p "$out/commands"

    cp apps/opencode-plugin/dist/index.js "$out/plugins/plannotator.js"
    cp apps/opencode-plugin/commands/plannotator-annotate.md "$out/commands/"
    cp apps/opencode-plugin/commands/plannotator-last.md "$out/commands/"
    cp apps/opencode-plugin/commands/plannotator-review.md "$out/commands/"

    runHook postInstall
  '';

  meta = {
    description = "Plannotator OpenCode plugin built from source";
    homepage = "https://github.com/backnotprop/plannotator";
    license = with lib.licenses; [
      mit
      asl20
    ];
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
