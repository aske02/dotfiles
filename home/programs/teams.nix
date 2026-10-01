{pkgs, ...}: {
  home.packages = with pkgs; [
    (teams-for-linux.override {
      electron_43 = electron_43-bin;
    })
  ];
}
