# home configuration.
{
  lib,
  isDarwin,
  isLinux,
  isOrb,
  ...
}: {
  imports =
    [
      ./dev/fish.nix
      ./dev/git.nix
      ./dev/shell.nix
      ./dev/neovim.nix
      ./dev/direnv.nix
      ./dev/search.nix
      ./sys/nix.nix
      ./net/ssh.nix
      ./net/utils.nix
      ./app/bat.nix
      ./app/basics.nix
      ./app/btop.nix
      ./app/cool.nix
      ./app/yazi.nix
      ./app/zellij.nix
      ./app/ghostty.nix
      # ./x11/vnc.nix
    ]
    ++ lib.optionals isDarwin [./darwin.nix]
    ++ lib.optionals isLinux [./linux.nix];

  home.stateVersion = "22.05";
}
