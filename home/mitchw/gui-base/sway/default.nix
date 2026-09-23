{ config, pkgs, lib, ... }:

{
  imports = [
    ./lamco.nix
  ];

  home.packages = with pkgs; [
    thunar

    wl-clipboard
    swayidle
    i3status
    wmenu

    grim
    slurp
  ];


  wayland.windowManager.sway = {
    enable = true;

    wrapperFeatures.gtk = true;
    
    # checkConfig = false;

    # extraConfig = ''
    #   set Control Control
    # '';

    config = {
      modifier = "Control";

      terminal = "alacritty";

      menu = "wmenu-run";

      keybindings = {
        "Control+Return" = "exec alacritty";
        "Control+d" = "exec wmenu-run";
        "Control+x" = "mode system";
        "Control+Tab" = "mode resize";
        "Control+space" = "mode container";

        "Control+q" = "kill";

        "Control+Shift+c" = "reload";
        "Control+Shift+r" = "restart";

        "Control+f" = "fullscreen toggle";

        "Control+h" = "focus left";
        "Control+j" = "focus down";
        "Control+k" = "focus up";
        "Control+l" = "focus right";

        "Control+0" = "workspace number 0";
        "Control+1" = "workspace number 1";
        "Control+2" = "workspace number 2";
        "Control+3" = "workspace number 3";
        "Control+4" = "workspace number 4";
        "Control+5" = "workspace number 5";
        "Control+6" = "workspace number 6";
        "Control+7" = "workspace number 7";
        "Control+8" = "workspace number 8";
        "Control+9" = "workspace number 9";

        "Control+Shift+space" = "focus mode_toggle";
      };

      modes = {
        container = {
          "0" = "workspace number 0";
          "1" = "workspace number 1";
          "2" = "workspace number 2";
          "3" = "workspace number 3";
          "4" = "workspace number 4";
          "5" = "workspace number 5";
          "6" = "workspace number 6";
          "7" = "workspace number 7";
          "8" = "workspace number 8";
          "9" = "workspace number 9";

          "Shift+0" = "move container to workspace number 0";
          "Shift+1" = "move container to workspace number 1";
          "Shift+2" = "move container to workspace number 2";
          "Shift+3" = "move container to workspace number 3";
          "Shift+4" = "move container to workspace number 4";
          "Shift+5" = "move container to workspace number 5";
          "Shift+6" = "move container to workspace number 6";
          "Shift+7" = "move container to workspace number 7";
          "Shift+8" = "move container to workspace number 8";
          "Shift+9" = "move container to workspace number 9";

          "h" = "focus left";
          "j" = "focus down";
          "k" = "focus up";
          "l" = "focus right";

          "Shift+h" = "move left";
          "Shift+j" = "move down";
          "Shift+k" = "move up";
          "Shift+l" = "move right";

          "v" = "split v";
          "b" = "split h";
          "f" = "floating toggle";

          "s" = "layout stacking";
          "t" = "layout tabbed";
          "e" = "layout toggle split";

          "Escape" = ''mode "default"'';
          "Return" = ''mode "default"'';
        };

        system = {
          "r" = "reload";
          "s" = "exec systemctl poweroff";
          "e" = "exit";

          "Escape" = ''mode "default"'';
          "Return" = ''mode "default"'';
        };

        resize = {
          "h" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize grow height 10 px or 10 ppt";
          "k" = "resize shrink height 10 px or 10 ppt";
          "l" = "resize grow width 10 px or 10 ppt";

          "Escape" = ''mode "default"'';
          "Return" = ''mode "default"'';
        };
      };

      bars = [
        {
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];

      input = {
        "*" = {
          xkb_layout = "us";
        };
      };

      startup = [
        # {
        #   command = "${pkgs.waybar}/bin/waybar";
        # }
        {
          command =
            "${pkgs.systemd}/bin/systemctl --user import-environment " +
            "WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS " +
            "XDG_RUNTIME_DIR XDG_SESSION_TYPE XDG_CURRENT_DESKTOP";
        }
        {
          command =
            "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd " +
            "WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS XDG_CURRENT_DESKTOP";
        }
        {
          command =
            "${pkgs.systemd}/bin/systemctl --user start lamco-rdp-server";
        }
      ];
    };

    # Critical for user services started after Sway.
    systemd.variables = [
      "--all"
    ];
  };
}
