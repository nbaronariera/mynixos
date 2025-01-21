{
  config,
  lib,
  ...
}:
let
  enableCachix = config.my.enableCachix or false;
in
{
  options.my.enableCachix = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Hyprland Cachix System in the system";
  };

  config = lib.mkIf enableCachix {
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };
}
