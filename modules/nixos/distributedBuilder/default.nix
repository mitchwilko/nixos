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
        hostName = "installation01";

        system = "aarch64-linux";
        systems = [
          "aarch64-linux"
        ];

        maxJobs = 6;
        speedFactor = 2;

        protocol = "ssh-ng";

        supportedFeatures = [ "big-parallel" ];
        mandatoryFeatures = [ ];
      }
      # {
      #   hostName = "thedawn";

      #   system = "x86_64-linux";
      #   systems = [
      #     "x86_64-linux"
      #   ];

      #   maxJobs = 8;
      #   speedFactor = 2;

      #   protocol = "ssh-ng";

      #   supportedFeatures = [ "big-parallel" ];
      #   mandatoryFeatures = [ ];
      # }
    ];
  };
}
