# modules/gui/xfce.nix

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # xinit
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = false;
  services.displayManager.autoLogin.enable = false;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.startx.enable = true;
  # services.xserver.displayManager.startx.generateScript = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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
