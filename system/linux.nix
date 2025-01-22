{
  lib,
  pkgs,
  owner,
  isDesktop,
  isHomeServer,
  isServer,
  isDarwin,
  isOrb,
  ...
}: {
  imports =
    [
      ./app/gnupg.nix
      ./gnome/dconf.nix
      ./media/fontconfig.nix
      ./net/networkmanager.nix
      ./sys/fwupd.nix
      ./sys/zram.nix
    ]
    ++ lib.optionals isDesktop [
      ./app/ghostty.nix
      ./gnome/gdm.nix
      ./gnome/gnome.nix
      ./gui/sway.nix
    ]
    ++ lib.optionals isOrb [
      ./sys/orb.nix
    ]
    ++ lib.optionals (!isOrb) [
      ./net/ssh.nix
    ]
    ++ lib.optionals isHomeServer [
    ]
    ++ lib.optionals isServer [
    ];

  # use the latest linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.swraid.enable = false;

  time.timeZone = "Asia/Colombo";

  networking.hostName =
    if isHomeServer
    then "shoko"
    else if isServer
    then "gojo"
    else if isOrb
    then "zenin"
    else "megumi";

  # set locale.
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "mac";
  console.useXkbConfig = true;

  # define a user account.
  users.extraUsers.${owner.name} = {
    description = owner.fullName;
    isNormalUser = true;
    initialPassword = owner.initialPassword;
    openssh.authorizedKeys.keys = owner.authorizedKeys;
    extraGroups = ["wheel"];
  };

  environment.systemPackages = with pkgs; [
    # tools to manipulate filesystems.
    coreutils
    file
    which
    tree
    dosfstools
    ms-sys
    mtools
    ntfsprogs
    parted
    testdisk
    # some archiver tools.
    unzip
    zip
    ghostty.terminfo
  ];

  # TODO: ghostty fiasco
  environment.enableAllTerminfo = true;
  environment.sessionVariables = {
    TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
  };

  # remove packages.
  documentation.nixos.enable =
    if !isOrb
    then false
    else true;

  # set state version.
  system.stateVersion = "22.05";
}
