{
  config,
  lib,
  ...
}: {
  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_mocha";
        vim_keys = true;
      };
    };
  };
  xdg.configFile = {
    "btop/themes" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/btop/themes;
      recursive = true;
    };
  };
}
