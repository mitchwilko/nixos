{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }; 

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nixos-generators,
    ...
  }:

  {
    nixosConfigurations = {

      mpswserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/mpswserver/default.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mitchw = {
              imports = [
                ./home/mitchw
                ./home/mitchw/cli-extra
                ./home/mitchw/gui-base
              ];
            };
          }
        ]; 
      };

      mpswthinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/mpswthinkpad/default.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mitchw = {
              imports = [
                ./home/mitchw
                ./home/mitchw/cli-extra
                ./home/mitchw/gui-base
                ./home/mitchw/gui-extra
              ];
            };
          }
        ]; 
      };

      nixvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/nixvm/default.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mitchw =
              import ./home/mitchw;
          }
        ]; 
      };

      mpswvps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/mpswvps/default.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mitchw = {
              imports = [
                ./home/mitchw
              ];
            };
          }
        ]; 
      };
    };

    darwinConfigurations = {
      mpswmacbook = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
    
        modules = [
          ./hosts/mpswmacbook/default.nix
    
          home-manager.darwinModules.home-manager
    
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
    
            home-manager.users.mitchw = {
              imports = [
                ./home/mitchw
                ./home/mitchw/cli-extra
              ];
            };
          }
        ];
      };
    };
    
    packages.x86_64-linux = {
      mpswvps-qcow =
        nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "qcow";
  
          modules = [
            ./hosts/mpswvps/default.nix
  
            home-manager.nixosModules.home-manager
  
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
  
              home-manager.users.mitchw =
                import ./home/mitchw;
            }
          ];
        };
    };
  };
}
