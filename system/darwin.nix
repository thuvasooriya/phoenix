{
  owner,
  lib,
  ...
}: {
  imports = [
    ./sys/brew.nix
    ./sys/darwin-defaults.nix
    ./gui/aerospace.nix
    ./dev/mac-cli.nix
  ];

  users.users.${owner.name} = {
    home = "/Users/${owner.name}";
  };

  ids.uids.nixbld = lib.mkForce 350;

  # set state version.
  system.stateVersion = 5;
}
