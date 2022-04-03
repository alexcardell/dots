{
  description = "NixOS system configuration (alexcardell)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    overlay-unstable = final: prev: {
      # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
      # use this variant if unfree packages are needed:
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

    lib = nixpkgs.lib;

  in {

    nixosConfigurations = {
      nixpad = lib.nixosSystem {
        inherit system;

	modules = [
          # make pkgs.unstable.package available
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

	  ./nixos/configuration.nix

	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true; 
	    home-manager.useUserPackages = true; 
	    home-manager.users.alex = import ./nixos/home.nix;
	  }
	];
      };
    };

  };
}
