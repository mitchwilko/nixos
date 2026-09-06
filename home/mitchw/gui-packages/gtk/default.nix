# home/gui-packages/gtk

{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.graphite-gtk-theme;
      name = "Graphite-Dark"; # or Graphite, Graphite-Light, etc. depending on variant
    };
  };
}
