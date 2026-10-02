{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
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
    nixos-hardware,
    nix-darwin,
    nixos-generators,
    ...
  }:

  {
    nixosConfigurations = {

      forge = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/forge

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

      thedawn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen2

          ./hosts/thedawn

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

      roland = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
      
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-3
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          # "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

          ./hosts/roland/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mitchw =
              import ./home/mitchw;
          }
        ]; 
      };

      installation04 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      
        modules = [
          ./hosts/installation04/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mitchw =
              import ./home/mitchw;
          }
        ]; 
      };

      installation01 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
      
        modules = [
          ./hosts/installation01/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mitchw =
              import ./home/mitchw;
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

      lamco-rdp-server =
       nixpkgs.legacyPackages.x86_64-linux.callPackage
        ./pkgs/lamco-rdp-server/package.nix {};
    };
  };
}
