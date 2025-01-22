{
  pkgs,
  owner,
  ...
}: let
  gitIgnoreGlobal =
    builtins.toFile "gitignore_global"
    ''
      # compiled source
      *.com
      *.class
      *.dll
      *.exe
      *.o
      *.so
      *.out

      # virtual environments
      **/.venv

      # logs and databases
      *.log
      *.sql
      *.sqlite

      # os generated files
      .DS_Store
      .DS_Store?
      ._.DS_Store
      **/.DS_Store
      **/._.DS_Store
      ._*
      .Spotlight-V100
      .Trashes
      ehthumbs.db
      Thumbs.db
    '';
in {
  home = {
    packages = with pkgs; [git-filter-repo jujutsu];
  };

  programs = {
    gh = {
      enable = true;
      settings = {
        version = "1";
      };
    };
    lazygit.enable = true;
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = owner.fullName;
      userEmail = owner.gitEmail;
      extraConfig = {
        init.defaultBranch = "main";
        core = {
          editor = "nvim";
          excludesFile = "${gitIgnoreGlobal}";
        };
        pull.ff = "only";
        merge.conflictstyle = "diff3";
        rerere = {
          enabled = true;
          autoUpdate = true;
        };
        column.ui = "auto";
        color.ui = true;
        branch.sort = "-committerdate";
        #core.fsmonitor = true; # watch FS for faster git status
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
      lfs = {
        enable = true;
        skipSmudge = true;
      };
    };
    gpg = {
      enable = true;
    };
  };
}
