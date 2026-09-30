{ pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  imports =
    [ # Include the results of the hardware scan.
      ../../modules/common
      ../../modules/common/fonts
      ../../modules/darwin
      ../../modules/darwin/homebrew
      ../../modules/darwin/ssh
      ../../modules/darwin/linuxBuilder
    ];

  networking.hostName = "mpswmacbook"; # Define your hostname.

  system.stateVersion = 6;
}
