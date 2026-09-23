# modules/gui/sway.nix

{ config, pkgs, ... }:

{
  programs.sway = {
    enable = true;

    # Allow GTK applications to behave correctly under Sway.
    wrapperFeatures.gtk = true;

    extraPackages = with pkgs; [
      mako
      grim
      slurp
    ];
  };

  # Required by a number of Wayland desktop applications.
  security.polkit.enable = true;

  # Useful for GTK/desktop applications.
  services.gnome.gnome-keyring.enable = true;

  # Hardware acceleration.
  hardware.graphics.enable = true;

  # Wayland keyboard layout.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Make Sway available as a display-manager session.
  services.displayManager.defaultSession = "sway";
}
