{ pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  imports =
    [ # Include the results of the hardware scan.
      ../../modules/common
      ../../modules/common/fonts
      ../../modules/darwin
      ../../modules/darwin/homebrew
    ];

  networking.hostName = "mpswmacbook"; # Define your hostname.

  system.stateVersion = 6;
}
