{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  enableHyprlandModule = config.my.enableHyprlandModule or false;
in
{
  options.my.enableHyprlandModule = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Hyprland in the system";
  };

  config = lib.mkIf enableHyprlandModule {
    programs.hyprland.enable = true;
    programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    environment.systemPackages = with pkgs; [
      hyprshot
      jq
      grim
      slurp
      hyprpicker
    ];
  };
}
