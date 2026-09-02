{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }; 

  outputs = { self, nixpkgs, home-manager, nixos-generators, ... }:

  {
    nixosConfigurations = {

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
                ./home/mitchw/gui-packages
                ./home/mitchw/cli-packages
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
                ./home/mitchw/gui-packages
                ./home/mitchw/cli-packages
              ];
            };
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

      # laptop = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";

      #   modules = [
      #     ./hosts/laptop/default.nix

      #     home-manager.nixosModules.home-manager

      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;

      #       home-manager.users.alice =
      #         import ./home/alice.nix;
      #     }
      #   ];
      # };

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
