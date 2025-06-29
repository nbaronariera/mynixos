{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableDiscord = config.my.enableDiscord or false;
in
{
  options.my.enableDiscord = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables Discord in the system";
  };

  config = lib.mkIf enableDiscord {
    environment.systemPackages = with pkgs; [
      vesktop
      electron
    ];
  };
}
