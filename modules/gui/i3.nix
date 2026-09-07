# modules/gui/i3.nix

{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = true;
      # startx.enable = true;
    };

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

  services.displayManager.defaultSession = "none+i3";
}
