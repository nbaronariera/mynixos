{
  config,
  pkgs,
  lib,
  ...
}:
let
  enableSystools = config.my.enableWaybar or false;
in
{
  options.my.enableSystools = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable systools in the system";
  };

  config = lib.mkIf enableSystools {
    home.packages = with pkgs; [
      libnotify
      swww
      rofi-wayland
      clipman
      cliphist
      pywal16
    ];

    programs.kitty = {
      enable = true;
      extraConfig = "include ~/.cache/wal/colors-kitty.conf";
    };

    services.mako = {
      enable = true;
      borderRadius = 5;
      defaultTimeout = 5000;
      maxVisible = 3;
      width = 200;
      height = 200;
      backgroundColor = "#454545bb";
    };

    home.file.".config/wal/templates/colors-hyprland.conf" = {
      text = ''
        $foreground = rgb({foreground.strip})
        $background = rgb({background.strip})
        $color0 = rgb({color0.strip})
        $color1 = rgb({color1.strip})
        $color2 = rgb({color2.strip})
        $color3 = rgb({color3.strip})
        $color4 = rgb({color4.strip})
        $color5 = rgb({color5.strip})
        $color6 = rgb({color6.strip})
        $color7 = rgb({color7.strip})
        $color8 = rgb({color8.strip})
        $color9 = rgb({color9.strip})
        $color10 = rgb({color10.strip})
        $color11 = rgb({color11.strip})
        $color12 = rgb({color12.strip})
        $color13 = rgb({color13.strip})
        $color14 = rgb({color14.strip})
        $color15 = rgb({color15.strip})
      '';
    };

    home.file.".config/wal/templates/colors-waybar.conf" = {
      text = ''
        @define-color foreground {foreground};
        @define-color background {background};
        @define-color cursor {cursor};

        @define-color color0 {color0};
        @define-color color1 {color1};
        @define-color color2 {color2};
        @define-color color3 {color3};
        @define-color color4 {color4};
        @define-color color5 {color5};
        @define-color color6 {color6};
        @define-color color7 {color7};
        @define-color color8 {color8};
        @define-color color9 {color9};
        @define-color color10 {color10};
        @define-color color11 {color11};
        @define-color color12 {color12};
        @define-color color13 {color13};
        @define-color color14 {color14};
        @define-color color15 {color15};
      '';
    };

    programs.cava = {
      enable = true;
      settings = {
        general = {
          framerate = 60;
          bars = 12;
          autosens = 1;
          stereo = true;
          monstercat = false;
        };
        input = {
          method = "pulse";
          source = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink.monitor";
        };
        smoothing.noise_reduction = 88;
        color = {
          gradient = 1;
          gradient_color_1 = "'#5d6436'";
          gradient_color_2 = "'#5d6436'";
          gradient_color_3 = "'#5d6436'";
          gradient_color_6 = "'#d59da2'";
          gradient_color_7 = "'#d59da2'";
          gradient_color_8 = "'#d59da2'";
        };
      };
    };
  };
}
