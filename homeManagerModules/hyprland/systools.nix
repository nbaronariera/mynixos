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
      kitty
      swww
      rofi-wayland
      clipman
      cliphist
      yazi
    ];

    services.mako = {
      enable = true;
      borderRadius = 5;
      defaultTimeout = 5000;
      maxVisible = 3;
      width = 200;
      height = 200;
      backgroundColor = "#454545bb";
    };
  };
}
