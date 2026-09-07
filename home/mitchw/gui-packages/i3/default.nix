{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dmenu
    i3status
    i3lock
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod1";

      terminal = "alacritty";

      menu = "dmenu_run";

      keybindings = {
        "$mod+Return" = "exec alacritty";
        "$mod+d" = "exec dmenu_run";
        "$mod+l" = "exec i3lock";

        "$mod+Shift+q" = "kill";

        "$mod+Shift+c" = "reload";
        "$mod+Shift+r" = "restart";

        "$mod+f" = "fullscreen toggle";

        "$mod+h" = "focus left";
        "$mod+j" = "focus down";
        "$mod+k" = "focus up";
        "$mod+l" = "focus right";

        "$mod+Shift+h" = "move left";
        "$mod+Shift+j" = "move down";
        "$mod+Shift+k" = "move up";
        "$mod+Shift+l" = "move right";

        "$mod+1" = "workspace number 1";
        "$mod+2" = "workspace number 2";
        "$mod+3" = "workspace number 3";
        "$mod+4" = "workspace number 4";
        "$mod+5" = "workspace number 5";

        "$mod+Shift+1" = "move container to workspace number 1";
        "$mod+Shift+2" = "move container to workspace number 2";
        "$mod+Shift+3" = "move container to workspace number 3";
        "$mod+Shift+4" = "move container to workspace number 4";
        "$mod+Shift+5" = "move container to workspace number 5";

        "$mod+v" = "split v";
        "$mod+b" = "split h";

        "$mod+s" = "layout stacking";
        "$mod+w" = "layout tabbed";
        "$mod+e" = "layout toggle split";

        "$mod+Shift+space" = "floating toggle";
        "$mod+space" = "focus mode_toggle";
      };

      modes = {
        resize = {
          "h" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize grow height 10 px or 10 ppt";
          "k" = "resize shrink height 10 px or 10 ppt";
          "l" = "resize grow width 10 px or 10 ppt";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };

      bars = [
        {
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];
    };
  };
}
