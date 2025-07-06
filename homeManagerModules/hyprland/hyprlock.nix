{
  config,
  lib,
  inputs,
  programs,
  security,
  ...
}:
let
  enableHyprlock = config.my.enableHyprlock or false;
in
{
  options.my.enableHyprlock = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Hyprlock and Hypridle in the system";
  };

  config = lib.mkIf enableHyprlock {
    programs.hyprlock = {
      enable = true;
      extraConfig = "";
      settings = {
        general = {
          disable_loading_bar = false;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "${config.home.homeDirectory}/Imágenes/lockimage.png"; # Se usa la variable de home para el fondo
            blur_passes = 1; # Según la configuración original, no había blur
            blur_size = 3; # Sin ajustes adicionales
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "300, 50";
            outline_thickness = 3;
            dots_size = 0.33;
            dots_spacing = 0.15;
            dots_center = true;
            dots_rounding = -1;
            outer_color = "rgb(151515)";
            inner_color = "rgb(FFFFFF)";
            font_color = "rgb(10, 10, 10)";
            fade_on_empty = true;
            fade_timeout = 1000;
            placeholder_text = ''<i>Input Password...</i>'';
            hide_input = false;
            rounding = -1;
            check_color = "rgb(204, 136, 34)";
            fail_color = "rgb(204, 34, 34)";
            fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
            fail_transition = 300;
            font_family = "Fira Code";
            capslock_color = -1;
            numlock_color = -1;
            bothlock_color = -1;
            invert_numlock = false;
            swap_font_color = false;
            position = "0, -20";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo '$TIME' ''; # Ajuste para el reloj
            color = "rgba(200, 200, 200, 1.0)";
            font_size = 55;
            font_family = "Fira Code";
            position = "-100, 70";
            halign = "right";
            valign = "bottom";
            shadow_passes = 5;
            shadow_size = 10;
          }
          {
            monitor = "";
            text = ''$USER''; # Ajuste para el nombre de usuario
            color = "rgba(200, 200, 200, 1.0)";
            font_size = 20;
            font_family = "Fira Code";
            position = "-100, 160";
            halign = "right";
            valign = "bottom";
            shadow_passes = 5;
            shadow_size = 10;
          }
        ];

        image = [
          {
            monitor = "";
            path = "${config.home.homeDirectory}/Imágenes/icon.png"; # Imagen adicional
            size = 200;
            rounding = -1;
            border_size = 4;
            border_color = "rgb(221, 221, 221)";
            rotate = 0;
            reload_time = -1;
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock "; # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session "; # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

        # Screenlock
        listener = [
          {
            # HYPRLOCK TIMEOUT
            timeout = 600;
            # HYPRLOCK ONTIMEOUT
            on-timeout = "loginctl lock-session";
          }

          # dpms
          {
            # DPMS TIMEOUT
            timeout = 660;
            # DPMS ONTIMEOUT
            on-timeout = "hyprctl dispatch dpms off";
            # DPMS ONRESUME
            on-resume = "hyprctl dispatch dpms on";
          }

          # Suspend
          {
            # SUSPEND TIMEOUT
            timeout = 1800;
            #SUSPEND ONTIMEOUT
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
