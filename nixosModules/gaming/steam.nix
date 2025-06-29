{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableSteam = config.my.enableSteam or false;
in
{
  options.my.enableSteam = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables Steam in the system";
  };

  config = lib.mkIf enableSteam {
    environment.systemPackages = with pkgs; [
      steam-run
      mangohud
    ];

    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;
  };
}
