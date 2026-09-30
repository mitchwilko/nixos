{ ... }:

{
  nix.linux-builder = {
    enable = true;

    maxJobs = 8;

    config = {
      virtualisation = {
        cores = 8;
        memorySize = 8192;
      };
    };
  };
}
