#

{ ... }:

{
  nix = {
    distributedBuilds = true;

    settings = {
      max-jobs = 6;
      builders-use-substitutes = true;
    };

    buildMachines = [
      {
        hostName = "thedawn";

        system = "x86_64-linux";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        maxJobs = 8;
        speedFactor = 2;

        protocol = "ssh-ng";

        supportedFeatures = [ "big-parallel" ];
        mandatoryFeatures = [ ];
      }
    ];
  };
}
