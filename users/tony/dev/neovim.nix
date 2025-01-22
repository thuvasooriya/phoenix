{
  pkgs,
  config,
  lib,
  isLinux,
  neovim-nightly,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ../dot/nvim;
    recursive = true;
  };
  home.packages = with pkgs;
    [
      (writeShellScriptBin "clean-nvim" ''
        rm -rf ${config.xdg.dataHome}/nvim
        rm -rf ${config.xdg.stateHome}/nvim
        rm -rf ${config.xdg.cacheHome}/nvim
      '')
      tree-sitter

      # zls
      # clang-tools
      # rust-analyzer

      nil
      alejandra

      # shfmt
      # asmfmt

      lua
      lua-language-server
      stylua

      # prettierd
      # vscode-langservers-extracted
      # biome

      # tectonic
      # typst
      # glow # markdown previewer in terminal
      # hugo
      # vale

      # ruff # build error
    ]
    ++ lib.optionals isLinux [
      xclip
    ];
}
