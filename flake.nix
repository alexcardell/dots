{
  description = "NixOS system configuration (alexcardell)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak?ref=v0.6.0";
    };

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nur,
      home-manager,
      darwin,
      nix-flatpak,
      # neovim-nightly-overlay,
      ...
    }:
    let
      darwinPkgConfiguration =
        { pkgs, ... }:
        {
          nix.package = pkgs.nixVersions.stable;
          nixpkgs.config.allowUnfree = true;
          # nix.extraOptions = ''
          #   experimental-features = nix-command flakes
          # '';
          # services.nix-daemon.enable = true;
        };

      overlay-unstable = system: final: prev: {
        # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        # use this variant if unfree packages are needed:
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };

      sharedOverlays = system: [
        (overlay-unstable system)
        nur.overlays.default
        # neovim-nightly-overlay.overlays.default
      ];

      nixosConfiguration =
        hostname:
        let
          system = "x86_64-linux";
          overlays =
            { ... }:
            {
              nixpkgs.overlays = sharedOverlays system;
            };
          os-configuration = ./nixos/systems/linux/configuration.nix;
          os-home = ./nixos/systems/linux/home/default.nix;
          host-configuration = (./nixos/hosts + "/${hostname}" + /configuration.nix);
          host-home = (./nixos/hosts + "/${hostname}" + /home/default.nix);
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            overlays
            os-configuration
            host-configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = {
                imports = [
                  nix-flatpak.homeManagerModules.nix-flatpak
                  os-home
                  host-home
                  ./nixos/home/default.nix
                ];
              };
            }
          ];
        };

        darwinConfiguration = let
            system = "aarch64-darwin";
            overlays = (
              { ... }:
              {
                nixpkgs.overlays = sharedOverlays system;
              }
            );
          in
          darwin.lib.darwinSystem {
            inherit system;

            modules = [
              overlays
              darwinPkgConfiguration
              ./nixos/systems/darwin/configuration.nix
              ./nixos/hosts/darwin/configuration.nix
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  users.alexcard = {
                    imports = [
                      ./nixos/systems/darwin/home/default.nix
                      ./nixos/hosts/darwin/home/default.nix
                      ./nixos/home/default.nix
                    ];
                  };
                };
              }
            ];
          };

    in
    {
      nixosConfigurations = {
        nixbox = nixosConfiguration "nixbox";
        # nixpad moved to private homelab repository
      };

      darwinConfigurations = {
        "RJ4QHFPQRX" = darwinConfiguration;
        "GTQ4XXD4Q9" = darwinConfiguration;
      };

      # Export reusable modules for other flakes (e.g., private homelab repo)
      nixosModules = {
        # Base Linux system configuration
        linuxSystem = ./nixos/systems/linux/configuration.nix;

        # Base Linux home-manager configuration
        linuxHome = ./nixos/systems/linux/home/default.nix;

        # Common home-manager configuration (works on Linux & Darwin)
        commonHome = ./nixos/home/default.nix;
      };

      formatter = {
        x86_64-linux = nixpkgs.legacyPackages."x86_64-linux".nixfmt-tree;
        aarch64-darwin = nixpkgs.legacyPackages."aarch64-darwin".nixfmt-tree;
      };
    };
}
