{pkgs, ...}: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = false;
      enableBashIntegration = false;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      enableTransience = true;
      settings = pkgs.lib.importTOML ../dot/starship.toml;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
    };
  };
  home.shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    nv = "nvim";
    cat = "bat";
    edsshgen = "ssh-keygen -t ed25519";
    zj = "zellij";
    v = "nvim";
    j = "just";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$GHOSTTY_BIN_DIR"
    "$HOME/.bun/bin"
    "$HOME/.cargo/bin"
    "$HOME/.pixi/bin"
  ];
}
