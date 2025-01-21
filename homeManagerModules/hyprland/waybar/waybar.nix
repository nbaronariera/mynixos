{
  config,
  pkgs,
  lib,
  ...
}:
let
  enableWaybar = config.my.enableWaybar or false;
in
{
  options.my.enableWaybar = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable waybar in the system";
  };

  config = lib.mkIf enableWaybar {
    programs.waybar = {
      enable = true;
      style = builtins.readFile "/home/nbr/Documentos/NixOs-Conf/homeManagerModules/hyprland/waybar/style.css";

      settings = [
        {
          #General Settings
          layer = "top";
          margin-top = 0;
          margin-bottom = 0;
          margin-left = 0;
          margin-right = 0;
          spacing = 0;
          reload_style_on_change = true;

          # Load Modules
          include = [
            "/home/nbr/Documentos/NixOs-Conf/homeManagerModules/hyprland/waybar/modules.json"
          ];

          # Modules Left
          modules-left = [
            "custom/appmenu"
            "group/links"
            #"group/settings"
            "wlr/taskbar"
            "group/quicklinks"
            #"hyprland/window"
            "custom/empty"
          ];

          # Modules Center
          modules-center = [
            "hyprland/workspaces"
          ];

          # Modules Right
          modules-right = [
            #"custom/updates"
            "pulseaudio"
            "bluetooth"
            "battery"
            "network"
            #"group/hardware"
            #"group/tools"
            "tray"
            "custom/hypridle"
            "custom/windowsvm"
            "custom/exit"
            #"custom/ml4w-welcome"
            "clock"
          ];
        }
      ];
    };
  };
}
