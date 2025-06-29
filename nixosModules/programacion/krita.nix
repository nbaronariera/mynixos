{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableKrita = config.my.enableKrita or false;
in
{
  options.my.enableKrita = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables krita in the system";
  };

  config = lib.mkIf enableKrita {
    environment.systemPackages = with pkgs; [
      krita
    ];
  };
}
