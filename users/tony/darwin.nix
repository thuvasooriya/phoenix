{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./dev/hdl.nix
  ];

  home.packages = with pkgs; [
    neofetch
    utm
  ];

  home.activation.removeOrbStackFishCompletions = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f $HOME/.config/fish/completions/docker.fish
    rm -f $HOME/.config/fish/completions/kubectl.fish
  '';
}
