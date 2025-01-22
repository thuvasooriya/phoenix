{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  virtualisation.docker.enable = true;
  imports = [
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];
  # documentation.enable = true;
  # documentation.nixos.enable = false;
}
