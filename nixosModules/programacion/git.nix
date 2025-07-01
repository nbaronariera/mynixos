{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableGit = config.my.enableGit or false;
in
{
  options.my.enableGit = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable git in the system";
  };

  config = lib.mkIf enableGit {
    environment.systemPackages = with pkgs; [
      git
      gh
    ];
  };
}
