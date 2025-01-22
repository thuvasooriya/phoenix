{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      hyperfine
      caligula # burning tool
      cmatrix
    ];
  };
}
