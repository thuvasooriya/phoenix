{
  owner,
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  # sudoers
  security.sudo.extraRules = [
    {
      users = [owner.name];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # add orbstack cli tools to path
  environment.shellInit = ''
    . /opt/orbstack-guest/etc/profile-early
    # add your customizations here
    . /opt/orbstack-guest/etc/profile-late
  '';
  environment.sessionVariables = {
    DISPLAY = "docker.for.mac.host.internal:0";
    JAVA_TOOL_OPTIONS = "-Dsun.java2d.xrender=false";
  };

  # resolv.conf: NixOS doesn't use systemd-resolved

  # faster DHCP - OrbStack uses SLAAC exclusively
  networking.dhcpcd.extraConfig = ''
    noarp
    noipv6
  '';
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  # disable sshd
  services.openssh.enable = false;

  # systemd
  systemd.services."systemd-oomd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-userdbd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-udevd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-timesyncd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-timedated".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-portabled".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-nspawn@".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-machined".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-localed".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-logind".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journald@".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journald".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journal-remote".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journal-upload".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-importd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-hostnamed".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-homed".serviceConfig.WatchdogSec = 0;

  # ssh config
  programs.ssh.extraConfig = ''
    Include /opt/orbstack-guest/etc/ssh_config
  '';

  # extra certificates
  security.pki.certificates = [
    ''

    ''
  ];

  # indicate builder support for emulated architectures
  nix.extraOptions = "extra-platforms = x86_64-linux i686-linux";
}
