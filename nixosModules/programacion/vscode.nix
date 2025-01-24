{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableVSCode = config.my.enableVSCode or false;
in
{
  options.my.enableVSCode = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables vscode in the system";
  };

  config = lib.mkIf enableVSCode {
    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}
