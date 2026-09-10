# modules/nixos/garbageCollect

{ ... }:

{
  nix.gc = {
    automatic = true;

    interval = {
      Weekday = 7;
      Hour = 3;
      Minute = 0;
    };

    options = "--delete-older-than 14d";
  };
}
