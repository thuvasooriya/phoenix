{
  pkgs,
  config,
  ...
}: let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "HEAD";
    hash = "sha256-oWdptgAtTAHX5u7lYe1o2TlvyCiOsuV1D5gm85J4dSE=";
  };
in {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    plugins = {
      chmod = "${yazi-plugins}/chmod.yazi";
      # full-border = "${yazi-plugins}/full-border.yazi";
      max-preview = "${yazi-plugins}/max-preview.yazi";
      mime-ext = "${yazi-plugins}/mime-ext.yazi";
      # mactag = "${yazi-plugins}/mactag.yazi";
      jump-to-char = "${yazi-plugins}/jump-to-char.yazi";
      no-status = "${yazi-plugins}/no-status.yazi";
      # starship = pkgs.fetchFromGitHub {
      #   owner = "Rolv-Apneseth";
      #   repo = "starship.yazi";
      #   rev = "HEAD";
      #   sha256 = "sha256-sAB0958lLNqqwkpucRsUqLHFV/PJYoJL2lHFtfHDZF8=";
      # };
      # rich-preview = pkgs.fetchFromGitHub {
      #   owner = "AnirudhG07";
      #   repo = "rich-preview.yazi";
      #   rev = "HEAD";
      #   sha256 = "sha256-sAB0958lLNqqwkpucRsUqLHFV/PJYoJL2lHFtfHDZF8=";
      # };
      ouch = pkgs.fetchFromGitHub {
        owner = "ndtoan96";
        repo = "ouch.yazi";
        rev = "v0.2.1";
        sha256 = "sha256-yLt9aY6hUIOdBI5bMdCs7VYFJGyD3WIkmPxvWKNCskA=";
      };
    };
  };

  home = {
    packages = with pkgs; [
      ouch
      miller
      # rich-cli
    ];
  };

  xdg.configFile = {
    "yazi/flavors" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/yazi/flavors;
      recursive = true;
    };
    "yazi/theme.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/yazi/theme.toml;
    };
    "yazi/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/yazi/starship.toml;
    };
    "yazi/keymap.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/yazi/keymap.toml;
    };
    "yazi/yazi.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/yazi/yazi.toml;
    };
    "yazi/init.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink ../dot/yazi/init.lua;
    };
  };
}
