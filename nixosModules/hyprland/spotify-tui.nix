{
  config,
  lib,
  ...
}:
let
  enableSpotifyTui = config.my.enableSpotifyTui or false;
in
{
  options.my.enableSpotifyTui = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable impala in the system";
  };

  config = lib.mkIf enableSpotifyTui {
    programs.spotify-tui.enable = true;
    programs.cava.enable = true;

  };
}

