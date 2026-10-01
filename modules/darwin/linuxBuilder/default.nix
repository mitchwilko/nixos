{ lib, ... }:

{
  nix.linux-builder = {
    enable = true;

    maxJobs = 8;

    config = {
      virtualisation = {
        cores = 8;
        darwin-builder.memorySize = lib.mkForce 16384;
        darwin-builder.diskSize = 100 * 1024;
      };
    };
  };
}
