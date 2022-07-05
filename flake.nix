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
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    darwin,
    ...
  }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
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

      overlay-unstable = final: prev: {
        # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        # use this variant if unfree packages are needed:
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
      darwinConfigurations = {
        "RJ4QHFPQRX" = darwin.lib.darwinSystem {
          inherit system;

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

            darwinConfiguration

            ./nix/darwin/configuration.nix

            home-manager.darwinModule {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.alexcard = import ./nix/home-manager/default.nix;
              };
            }
          ];
        };
      };
    };

}
