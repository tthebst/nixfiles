{

  description = "Tim's NixOS and MacOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, home-manager, nixpkgs, ... }@inputs: {

    # My Macbook Pro 16"
    darwinConfigurations = {
      "Tims-MBP" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./macos
        ];
        inputs = { inherit darwin home-manager nixpkgs; };
      };
     };

    # My NixOS machine
    nixosConfigurations = {
      homelab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
          modules = [
            ./nixos
            ./hardware/homelab.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tim = import ./nixos/home-manager.nix;
            }
          ];
         specialArgs = {
          inherit inputs;
         };

        };
      };
  };
}
