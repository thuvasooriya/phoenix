{
  description = ".phoenix";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-packages = {
      url = "github:wegank/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nur-packages,
    ...
  } @ inputs: let
    metadata = builtins.fromTOML (builtins.readFile ./flake.toml);
    lib = nixpkgs.lib;
    # filter machines by suffix.
    filterMachines = suffix: (lib.filterAttrs (_: config: lib.hasSuffix suffix config.platform) metadata.machines);

    # get username.
    getUserName = name: host: let
      fullName = lib.splitString " " (lib.toLower metadata.users.${name}.fullName);
    in
      if (lib.hasSuffix "darwin" host.platform)
      then lib.concatStrings fullName
      else lib.head fullName;

    # set special args.
    setSpecialArgs = host: {
      isDarwin = lib.hasSuffix "darwin" host.platform;
      isLinux = lib.hasSuffix "linux" host.platform;
      isDesktop = host.profile == "desktop";
      isHomeServer = host.profile == "home-server";
      isOrb = host.profile == "orb";
      isServer = host.profile == "server";
      owner =
        metadata.users.${metadata.owner.name}
        // {
          name = getUserName metadata.owner.name host;
        };
      # TODO: what is this
      nur-pkgs = import nur-packages {pkgs = import nixpkgs {system = host.platform;};};
      # TODO: move this into overlays
      neovim-nightly = inputs.neovim-nightly.packages.${host.platform}.default;
      overlays = [
        inputs.zig.overlays.default
      ];
    };

    # set home manager template.
    setHomeManagerTemplate = host: {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = setSpecialArgs host;
        users =
          lib.mapAttrs' (
            name: _: lib.nameValuePair (getUserName name host) (./users + "/${name}" + /home.nix)
          )
          metadata.users;
      };
    };
  in {
    # macos configurations.
    darwinConfigurations = builtins.mapAttrs (
      hostname: host:
        nix-darwin.lib.darwinSystem {
          system = host.platform;
          specialArgs = setSpecialArgs host;
          modules = [
            # nix modules.
            ./modules/environment.nix
            # system configuration.
            ./system/configuration.nix
            # home manager configuration.
            home-manager.darwinModules.home-manager
            (setHomeManagerTemplate host)
          ];
        }
    ) (filterMachines "darwin");

    # nixos configurations.
    nixosConfigurations = builtins.mapAttrs (
      hostname: host:
        nixpkgs.lib.nixosSystem {
          system = host.platform;
          specialArgs = setSpecialArgs host;
          modules = [
            # nix modules.
            ./modules/environment.nix
            # hardware configuration.
            (./hardware + "/${hostname}" + /hardware-configuration.nix)
            # system configuration.
            ./system/configuration.nix
            # home manager configuration.
            home-manager.nixosModules.home-manager
            (setHomeManagerTemplate host)
          ];
        }
    ) (filterMachines "linux");
  };
}
