{
  config,
  pkgs,
  lib,
  ...
}:

let
  enablePython = config.my.enablePython or false;
in
{
  options.my.enablePython = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable pip in the system";
  };

  config = lib.mkIf enablePython {
    environment.systemPackages = with pkgs; [
      python3
      (python3.withPackages (ps: with ps; [ pip ]))
      thefuck
    ];
  };
}
