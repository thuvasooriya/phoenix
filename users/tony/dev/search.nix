{config, ...}: {
  programs = {
    jq.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
  };

  home.file = {
    ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../dot/.rgignore;
  };
}
