{ pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  imports =
    [ # Include the results of the hardware scan.
      ../../modules/darwin/users
      # ../../modules/darwin/homebrew
      ../../modules/fonts
    ];

  networking.hostName = "mpswmacbook"; # Define your hostname.

  system.stateVersion = 6;
}
