{ config, lib, ... }:
let
  enableAllHyprland = config.my.enableAllHyprland or false;
in
{
  options.my.enableAllHyprland = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Hyprland";
  };

  imports = [
    ./hyprland.nix
    ./systools.nix
    ./waybar/waybar.nix
    ./wlogout.nix
    ./hyprlock.nix
    ./yazi.nix
  ];

  config = lib.mkIf enableAllHyprland {
    #Enable Hyprland cache
    my.enableHyprland = true;
    my.enableHyprlock = true;
    my.enableSystools = true;
    my.enableWaybar = true;
    my.enableWLogout = true;
    my.enableYazi = true;
  };
}
