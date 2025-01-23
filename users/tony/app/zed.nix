{
  owner,
  config,
  ...
}: {
  xdg.configFile = {
    "zed" = {
      # the non nix way for faster iteration
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${owner.configDir}/users/tony/dot/zed";
      # change to this when you have a solid config
      # source = config.lib.file.mkOutOfStoreSymlink ../dot/zed;
      # recursive = true;
    };
  };
}
