{pkgs, ...}: {
  home.packages = with pkgs; [
    (teams-for-linux.override {
      electron_41 = electron_41-bin;
    })
  ];
}
