{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    bat = {
      enable = true;
      config = {
        theme = "catppuccin_mocha";
      };
    };
  };
  xdg.configFile = {
    "bat/themes" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/bat/themes;
      recursive = true;
    };
  };
}
