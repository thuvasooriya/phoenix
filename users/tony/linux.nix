{
  lib,
  pkgs,
  isDesktop,
  ...
}: {
  imports =
    [
      ./x11/gtk.nix
      ./x11/xdg.nix
    ]
    ++ lib.optionals isDesktop [
      ./gnome/dconf.nix
      ./gui/sway.nix
    ];

  home = {
    packages = with pkgs; [
      neofetch
      screen
    ];
  };
}
