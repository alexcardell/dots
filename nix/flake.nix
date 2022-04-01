{
  description = "NixOS system configuration (alexcardell)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {

    nixosConfigurations = {
      nixpad = lib.nixosSystem {
        inherit system;

	modules = [
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
