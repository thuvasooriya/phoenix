{
  owner,
  config,
  ...
}: {
  xdg.configFile = {
    "neovide" = {
      # the non nix way for faster iteration
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${owner.configDir}/users/tony/dot/neovide";
      # change to this when you have a solid config
      # source = config.lib.file.mkOutOfStoreSymlink ../dot/neovide;
    };
  };
}
