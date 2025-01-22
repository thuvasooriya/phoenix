{
  homebrew = {
    enable = true;
    onActivation = {
      # autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  homebrew.brews = [
    # "gmp"
    # "curl"
  ];

  homebrew.taps = [
    # "homebrew/cask-drivers"
  ];

  # TODO: backup the cask configurations
  homebrew.casks = [
    ### dev ###
    "orbstack"
    "visual-studio-code"
    "zed"
    "android-platform-tools"

    ### social ###
    "whatsapp"
    "discord"

    ### utils ###
    # "syncthing"
    # "raycast"
    # "arc"
    "zoom"
    "handbrake"
    # "altserver"
    # "chatgpt"
    "obs"
    ### tmp ###
    "keyclu"
    "keka"
    "lunar"
    # "orion"
    # "spotube"
    # "inkscape"
    # "blender"
    # "element"
    # "gimp"
    # "playcover-community"
    # "prolific-pl2303"
  ];
}
