{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Define el paquete modificado
  customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  enableWaybar = config.my.enableWaybar or false;
in
{
  options.my.enableWaybar = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable waybar in the system";
  };

  config = lib.mkIf enableWaybar {
    # Activa la gestión de paquetes con Home Manager
    home.packages = with pkgs; [
      customWaybar
    ];

    #customWaybar.configFile = "./config.jsonc";
    #customWaybar.cssFile = "./syle.css";
  };
}
