{ config, lib, ... }:

let
  cfg = config.myNetwork;
in
{
  options.myNetwork.externalInterface = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Interface used for container NAT.";
  };

  config = lib.mkIf (cfg.externalInterface != null) {
    networking.nat = {
      enable = true;
      internalInterfaces = [ "ve-*" ];
      externalInterface = cfg.externalInterface;
    };
  };
}
