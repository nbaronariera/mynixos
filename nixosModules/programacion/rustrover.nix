{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableRustRover = config.my.enableRustRover or false;
in
{
  options.my.enableRustRover = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable RustRover in the system";
  };

  config = lib.mkIf enableRustRover {
    environment.systemPackages = with pkgs; [
      jetbrains.rust-rover
    ];
  };
}
