# hardware configuration.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  # don't require password for sudo
  security.sudo.wheelNeedsPassword = false;
  # virtualization settings
  virtualisation.docker.enable = true;
  virtualisation.lxd = {
    enable = true;
  };
  # virtualisation.rosetta.enable = true;

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "sr_mod"
        # "virtiofs"
      ];
      kernelModules = [];
    };
    kernelModules = [];
    kernelParams = [
      "root=/dev/sda2"
      "xhci_hcd.quirks=0x40"
    ];
    extraModulePackages = [];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      # vmware, parallels both only support this being 0 otherwise you see
      # "error switching console mode" on boot.
      systemd-boot.consoleMode = "0";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      # fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    # "/run/rosetta" = {
    #   device = "rosetta";
    #   fsType = "virtiofs";
    # };
  };

  # nix.settings.extra-platforms = ["x86_64-linux"];
  # nix.settings.extra-sandbox-paths = ["/run/rosetta" "/run/binfmt"];
  # boot.binfmt.registrations."rosetta" = {
  #   # based on https://developer.apple.com/documentation/virtualization/running_intel_binaries_in_linux_vms_with_rosetta#3978495
  #   interpreter = "/run/rosetta/rosetta";
  #   fixBinary = true;
  #   wrapInterpreterInShell = false;
  #   matchCredentials = true;
  #   magicOrExtension = ''\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x3e\x00'';
  #   mask = ''\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'';
  # };

  swapDevices = [];

  hardware.parallels = {
    enable = true;
    package = config.boot.kernelPackages.prl-tools.overrideAttrs (
      finalAttrs: previousAttrs: {
        version = "20.2.0-55872";
        src = previousAttrs.src.overrideAttrs {
          outputHash = "sha256-oOilbF5MzZxZXNVQYAp/JxyMVdM0oltG8pGfzzsQ1kY=";
        };
        installPhase =
          builtins.replaceStrings
          [
            "cp prl_fs/SharedFolders/Guest/Linux/prl_fs/prl_fs.ko $out/lib/modules/${config.boot.kernelPackages.kernel.modDirVersion}/extra"
            "mkdir -p $out/share/man/man8"
            "install -Dm644 ../mount.prl_fs.8 $out/share/man/man8"
          ]
          [
            ""
            ""
            ""
          ]
          previousAttrs.installPhase;
      }
    );
  };

  environment.unfreePackages = ["prl-tools"];
}
