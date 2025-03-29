{
  config,
  lib,
  ...
}:
let
  enableWLogout = config.my.enableWLogout or false;
in
{
  options.my.enableWLogout = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable wlogout in the system";
  };

  config = lib.mkIf enableWLogout {
    programs.wlogout = {
      enable = true;
    };
  };
}
