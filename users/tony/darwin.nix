{pkgs, ...}: {
  imports = [
    ./dev/hdl.nix
  ];

  home.packages = with pkgs; [
    neofetch
    utm
  ];
}
