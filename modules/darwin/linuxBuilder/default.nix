{ lib, ... }:

{
  nix.linux-builder = {
    enable = true;

    maxJobs = 8;

    config = {
      virtualisation = {
        cores = 8;
        memorySize = lib.mkForce 16 * 1024;
        darwin-builder.diskSize = 100 * 1024;
      };
    };
  };
}
