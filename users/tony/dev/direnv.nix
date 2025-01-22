{
  programs = {
    direnv = {
      enable = true;
      config = {
        whitelist = {
          prefix = [
            "$HOME/dev"
          ];
          exact = ["$HOME/.envrc"];
        };
      };
      nix-direnv.enable = true;
    };
  };
}
