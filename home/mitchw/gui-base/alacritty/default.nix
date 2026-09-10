{ pkgs, ... }:

{
  # Set this to be the default terminal
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  # Program settings for Alacritty
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
      };

      window = {
        opacity = 0.95;

        padding = {
          x = 8;
          y = 8;
        };
      };

      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };

        size = 10;
      };

      scrolling.history = 10000;

      selection.save_to_clipboard = true;

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
      };

      colors.cursor = {
        text = "#000000";
        cursor = "#5C9DED";
      };
    };
  };
}
