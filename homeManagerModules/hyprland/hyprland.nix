{
  config,
  pkgs,
  inputs,
  lib,
  services,
  ...
}:
let
  enableHyprland = config.my.enableHyprland or false;

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    sleep 1 &
    ${pkgs.waybar}/bin/waybar &
    sleep 1 &
    bash $HOME/Imágenes/swww_wallpapers/swww.sh
  '';
in
{
  options.my.enableHyprland = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Hyprland in the system by Home Manager";
  };

  config = lib.mkIf enableHyprland {
    #xdg.portal.config.default = "*";

    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.hyprland = {
      enable = true;

      plugins = [ ];
      settings = {
        exec-once = [
          ''${startupScript}/bin/start''
          "hyprctl setcursor Bibata-Modern-Classic 24"
          "wlsunset -l 39.49 -L -0.38"
        ];

        source = [
          "$HOME/.cache/wal/colors-hyprland.conf"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "HYPRCURSOR_THEME, Bibata-Modern-Classic"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          "col.active_border" = "$color1 $color1 $color2  45deg";
          "col.inactive_border" = "$foreground";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false;

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;

          layout = "dwindle";
        };

        decoration = {
          rounding = 10;

          # Change transparency of focused and unfocused windows
          active_opacity = 0.99;
          inactive_opacity = 0.95;

          shadow = {
            enabled = true;
            range = 6;
            render_power = 4;
            color = "rgba(1a1a1aee)";
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          dim_special = 0.2;
          blur = {
            special = true;
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        dwindle = {
          pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # You probably want this
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
          new_status = "master";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc = {
          force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        };

        input = {
          kb_layout = "es";
          #kb_variant =
          #kb_model =
          #kb_options =
          #kb_rules =

          follow_mouse = 1;

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          touchpad = {
            natural_scroll = true;
          };
        };

        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gestures = {
          workspace_swipe = true;
        };

        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        # Ignore maximize requests from apps. You'll probably like this.
        windowrulev2 = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "float, class:sxiv"
        ];

        monitor = [
          "eDP-1,1920x1080,0x0,1"
          ",preferred,auto,auto"
        ];

        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "~/Documentos/NixOs-Conf/homeManagerModules/hyprland/rofi/launcher.sh";

        bind =
          [
            "$mod SHIFT, M, exec, hyprctl dispatch exit"
            "$mod SHIFT, R, exec, hyprctl reload"
            "$mod SHIFT, f, fullscreen"

            # Apps
            "$mod, F, exec, firefox"
            "$mod, V, exec, vscode"
            "$mod, L, exec, hyprlock"
            "Ctrl+Alt,Delete,exec,wlogout"
            "Ctrl+Shift,Escape,exec,kitty -e btop"

            # Capturas
            ", PRINT, exec, hyprshot --freeze -m output"
            "$mod, PRINT, exec, hyprshot --freeze -m active"
            "$mod SHIFT, PRINT, exec, hyprshot --freeze -m region"

            "$mod, T, exec, sxiv -g 1000x800 /home/nbr/Imágenes/teclado/*"

            # Ajustar el volumen
            ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%" # Subir volumen 5%
            ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%" # Bajar volumen 5%
            ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle" # Silenciar/activar sonido

            "$mod, minus, resizeactive, -20 -20"
            "$mod, plus, resizeactive, 20 20"

            "$mod, RETURN, exec, $terminal"
            "$mod, Y, exec, kitty -e yazi"
            "$mod, Q, killactive,"
            "$mod, E, exec, $fileManager"
            "$mod, V, togglefloating,"
            "$mod, R, exec, $menu"
            "$mod, P, pseudo," # dwindle
            "$mod, J, togglesplit," # dwindle

            # Move focus with mainMod + arrow keys
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            "$mod, RIGHT, workspace, e+1"
            "$mod, LEFT, workspace, e-1"

            # Example special workspace (scratchpad)
            "$mod, S, exec, /home/nbr/Documentos/NixOs-Conf/homeManagerModules/hyprland/hyprscratch.sh kitty kitty terminal"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9
            )
          );

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        # Laptop multimedia keys for volume and LCD brightness
        bindel = [
          ",XF86AudioRaiseVolume, exec, pactl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, pactl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, pactl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, pactl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ];

        # Requires playerctl
        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
      };
    };
  };
}
