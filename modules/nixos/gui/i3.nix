# modules/gui/i3.nix

{ config, pkgs, ... }:

{
  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
    };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
