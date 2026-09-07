# modules/gui/xfce.nix

{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = false;
      startx.enable = true;
    };

    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
  
    windowManager.i3.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  
  services.displayManager.defaultSession = "xfce";
  services.displayManager.autoLogin.enable = false;

  environment.etc."X11/xinit/xinitrc".text = ''
    #!/bin/sh
    exec startxfce4
  '';

  environment.systemPackages = with pkgs; [
    # xinit
    # graphite-gtk-theme
  ];

  environment.xfce.excludePackages = with pkgs; [
    xfce4-terminal
    mousepad
    # parole # Image Previewer
    # ristretto # Video Previewer
    xfce4-screenshooter
    xfce4-taskmanager
    xfce4-notes-plugin
    orage # Calendaer
    xfce4-dict
    xfburn # Optical CD Burner
  ];

  # Autologin required for sunshine
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "mitchw";
  # };
}
