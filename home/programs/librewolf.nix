{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
    profiles.default = {
      extensions.packages = with inputs.NUR.legacyPackages.${system}.repos.rycee.firefox-addons; [
        ublock-origin
        sponsorblock
        refined-github
      ];
      id = 0;

      settings = {
        "extensions.autoDisableScopes" = 0;

        "browser.search.defaultenginename" = "Google";
        "browser.search.selectedEngine" = "Google";
        "browser.urlbar.placeholderName" = "Google";

        "pdfjs.disabled" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      };

      search = {
        default = "google";
        engines = {
          amazon.metaData.hidden = true;
          amazondotcom-us.metaData.hidden = true;
          ebay.metaData.hidden = true;
          policy-MetaGer.metaData.hidden = true;
          policy-StartPage.metaData.hidden = true;
          policy-Mojeek.metaData.hidden = true;
          policy-SearXNG.metaData.hidden = true;
          mojeek.metaData.hidden = true;
          bing.metaData.hidden = true;
          searxng.metaData.hidden = true;
          wikipedia.metaData.hidden = true;

          google.metaData.alias = "@g";
          google.metaData.hidden = false;

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            definedAliases = ["@nw"];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
          };

          nix-packages = {
            name = "Nixpkgs";
            urls = [
              {
                template = "https://search.nixos.org/packages?query={searchTerms}";
              }
            ];
            iconMapObj."16" = "https://search.nixos.org/favicon.png";
            definedAliases = ["@np"];
          };

          nixos-options = {
            name = "NixOS";
            urls = [
              {
                template = "https://search.nixos.org/options?query={searchTerms}";
              }
            ];
            iconMapObj."16" = "https://search.nixos.org/favicon.png";
            definedAliases = ["@no"];
          };
        };
        force = true;
      };
    };
  };
}
