{config, ...}: {
  programs.zellij.enable = true;
  xdg.configFile = {
    "zellij" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/zellij;
      recursive = true;
    };
  };
}
