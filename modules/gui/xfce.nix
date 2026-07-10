# modules/gui/xfce.nix

{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.autoLogin.enable = false;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  #environment.systemPackages = with pkgs; [
  #  xorg.xinit
  #];

  # Autologin required for sunshine
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "mitchw";
  # };
}
