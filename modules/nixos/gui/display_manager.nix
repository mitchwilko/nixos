{ ... }:

{
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = true;
      # startx.enable = true;
    };
  }

  services.displayManager.defaultSession = "none+i3";
  # services.displayManager.defaultSession = "sway";

  # environment.etc."X11/xinit/xinitrc".text = ''
  #   #!/bin/sh
  #   exec i3
  # '';
}
