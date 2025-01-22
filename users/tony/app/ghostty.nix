{
  pkgs,
  config,
  lib,
  isDarwin,
  isLinux,
  ...
}: {
  xdg.configFile = {
    "ghostty/config" = {
      source = config.lib.file.mkOutOfStoreSymlink (
        if isDarwin
        then ../dot/ghostty/darwin-config
        else ../dot/ghostty/linux-config
      );
    };
  };
}
