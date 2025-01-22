{pkgs, ...}: {
  manual = {
    manpages = {
      enable = false;
    };
  };

  home = {
    packages = with pkgs; [
      cachix
      nil
      nixfmt-rfc-style
      nixpkgs-review
    ];
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
