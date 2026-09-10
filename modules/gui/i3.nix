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

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd i3";
  #       user = "greeter";
  #     };
  #   };
  # };

  services.displayManager.defaultSession = "none+i3";
}
