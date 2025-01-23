{
  lib,
  isOrb,
  ...
}: {
  programs.ssh = {
    enable = true;
  };

  programs = {
    keychain = {
      enable =
        if isOrb
        then false
        else true;
      enableFishIntegration = true;
      keys = ["id_ed25519"];
    };
  };
}
