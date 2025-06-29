{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableNixfmt = config.my.enableNixfmt or false;
in
{
  options.my.enableNixfmt = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables git in the system";
  };

  config = lib.mkIf enableNixfmt {
    environment.systemPackages = with pkgs; [
      nixfmt-rfc-style
    ];
  };
}
