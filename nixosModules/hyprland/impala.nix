{
  config,
  lib,
  ...
}:
let
  enableImpala = config.my.enableImpala or false;
in
{
  options.my.enableImpala = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable impala in the system";
  };

  config = lib.mkIf enableImpala {
    programs.impala.enable = true;
  };
}

