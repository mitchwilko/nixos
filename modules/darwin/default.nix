#/modules/common/default.nix

{ ... }:

{
  imports = [
    ./garbageCollect
    ./users
  ];
}
