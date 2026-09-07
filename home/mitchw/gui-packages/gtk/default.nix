# home/gui-packages/gtk

{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      # Pass the 'nord' tweak to compile the theme with the Nord palette
      package = pkgs.graphite-gtk-theme.override {
        tweaks = [ "nord" ]; # options include: "nord", "black", "rimless", "darker"
      };
      # The resulting theme name usually suffixes the main variant names
      name = "Graphite-Dark-Nord"; 
      # name = "Graphite-Dark"; # or Graphite, Graphite-Light, etc. depending on variant
    };

    # (Optional) Pair it with matching Icon and Cursor themes
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    cursorTheme = {
      package = pkgs.graphite-cursors;
      name = "Graphite-Dark";
    };

    # Force GTK apps to respect the dark layout preference
    gtk3.extraConfig = {
      gtk-application-prefer-dark-themes = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-themes = 1;
    };
  };
}
