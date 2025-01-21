{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableHeroic = config.my.enableHeroic or false;
in
{
  options.my.enableHeroic = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables Steam in the system";
  };

  config = lib.mkIf enableHeroic {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
