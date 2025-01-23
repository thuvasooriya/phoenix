{
  config,
  owner,
  ...
}: {
  programs.zellij.enable = true;
  xdg.configFile = {
    "zellij" = {
      # the non nix way for faster iteration
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${owner.configDir}/users/tony/dot/zellij";
      # change to this when you have a solid config
      # source = config.lib.file.mkOutOfStoreSymlink ../dot/zellij;
    };
  };
}
