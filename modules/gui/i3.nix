# modules/gui/i3.nix

{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = false;
      startx.enable = true;
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

  # Start i3 when running `startx`
  environment.etc."X11/xinit/xinitrc".text = ''
    #!/bin/sh
    exec i3
  '';

  environment.systemPackages = with pkgs; [
    i3
    i3status
    dmenu
  ];
}
