{pkgs, ...}: {
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
}
