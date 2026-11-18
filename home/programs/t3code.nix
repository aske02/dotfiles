{pkgs, ...}: {
  home.packages = with pkgs; [
    t3code
  ];
}
