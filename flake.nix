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

      lib = nixpkgs.lib;

    in
    {
      nixosConfigurations = {
        nixpad = let
          system = "x86-64-linux";
        in
          lib.nixosSystem {
            modules = [
              # make pkgs.unstable.package available
              ({ config, pkgs, ... }: {
                nixpkgs.overlays = [ (overlay-unstable system) ];
              })

              ./nixos/configuration.nix

              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.alex = import ./nixos/home.nix;
              }
            ];
          };
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
                nixpkgs.overlays = [ 
                  (overlay-unstable system) 
                  neovim-nightly.overlay
                ];
              })

              darwinConfiguration

              ./nixos/hosts/darwin/configuration.nix

              home-manager.darwinModule
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.alexcard = import ./nixos/home.nix;
                };
              }
            ];
          };
      };
    };
}
