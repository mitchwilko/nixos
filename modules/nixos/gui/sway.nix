# modules/gui/sway.nix

{ config, pkgs, ... }:

{
  programs.sway = {
    enable = true;

    # Allow GTK applications to behave correctly under Sway.
    wrapperFeatures.gtk = true;
  };

  # Required by a number of Wayland desktop applications.
  security.polkit.enable = true;

  # Useful for GTK/desktop applications.
  services.gnome.gnome-keyring.enable = true;

  # Hardware acceleration.
  hardware.graphics.enable = true;
}
