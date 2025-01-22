{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      nodejs
      python312
      zigpkgs."0.13.0"
    ];
  };
}
