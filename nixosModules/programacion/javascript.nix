{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableJS = config.my.enableJS or false;
in
{
  options.my.enableJS = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable js in the system";
  };

  config = lib.mkIf enableJS {
    environment.systemPackages = with pkgs; [
      nodejs_22
    ];
  };
}
