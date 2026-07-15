{ pkgs, ... }: {
  # Install fastfetch
  home.packages = [ pkgs.fastfetch ];

  # Configure fastfetch with all default modules explicitly written out
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "poweradapter"
        "locale"
        "colors"
      ];
    };
  };
}
