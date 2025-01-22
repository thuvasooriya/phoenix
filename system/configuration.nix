# system configuration.
{
  lib,
  isDarwin,
  isLinux,
  ...
}: {
  imports =
    [
      ./app/fish.nix
      ./media/font.nix
      ./sys/nix.nix
      ./x11/xorg-server.nix
    ]
    ++ lib.optionals isDarwin [./darwin.nix]
    ++ lib.optionals isLinux [./linux.nix];
}
