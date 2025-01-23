{
  pkgs,
  config,
  owner,
  ...
}: {
  home = {
    packages = with pkgs; [
      rclone
      rsync

      # socat # replacement of openbsd-netcat
      # curl
      wget
      dogdns
      nmap # a utility for network discovery and security auditing
      aria2 # a lightweight multi-protocol & multi-source command-line download utility
    ];
  };

  xdg.configFile = {
    "aria2" = {
      # the non nix way for faster iteration
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${owner.configDir}/users/tony/dot/aria2";
      # change to this when you have a solid config
      # source = config.lib.file.mkOutOfStoreSymlink ../dot/aria2;
    };
    "yt-dlp" = {
      # the non nix way for faster iteration
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${owner.configDir}/users/tony/dot/yt-dlp";
      # change to this when you have a solid config
      # source = config.lib.file.mkOutOfStoreSymlink ../dot/yt-dlp;
    };
  };
}
