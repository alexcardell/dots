{
  description = "NixOS system configuration (alexcardell)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, darwin, neovim-nightly, ... }:
    let
      # system = "x86_64-linux";

      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      darwinConfiguration = { pkgs, ... }: {
        nix.package = pkgs.nixFlakes;
        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';
        services.nix-daemon.enable = true;
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
        neovim-nightly.overlay
      ];

      nixosConfiguration = hostname:
        let
          system = "x86_64-linux";
          overlays = ({ config, pkgs, ... }: {
            nixpkgs.overlays = sharedOverlays system;
          });
          system-configuration = (./nixos/systems/linux/configuration.nix);
          host-configuration = (./nixos/hosts + "/${hostname}" + /configuration.nix);
          host-home = (./nixos/hosts + "/${hostname}" + /home/default.nix);
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            overlays
            system-configuration
            host-configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = {
                imports = [
                  ./nixos/systems/linux/home/default.nix
                  host-home
                  ./nixos/home.nix
                ];
              };
            }

          ];
        };

    in
    {
      nixosConfigurations = {
        nixbox = nixosConfiguration "nixbox";

        nixpad = nixosConfiguration "nixpad";
      };

      darwinConfigurations = {
        "RJ4QHFPQRX" =
          let
            system = "aarch64-darwin";
          in
          darwin.lib.darwinSystem {
            inherit system;

            modules = [
              ({ config, pkgs, ... }: {
                nixpkgs.overlays = sharedOverlays system;
              })

              darwinConfiguration

              ./nixos/systems/darwin/configuration.nix

              ./nixos/hosts/darwin/configuration.nix

              home-manager.darwinModule
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  users.alexcard = {
                    imports = [
                      ./nixos/systems/darwin/home/default.nix
                      ./nixos/hosts/darwin/home/default.nix
                      ./nixos/home.nix
                    ];
                  };
                };
              }
            ];
          };
      };
    };
}
