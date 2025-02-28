{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableDocker = config.my.enableDocker or false;
in
{
  options.my.enableDocker = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables docker in the system";
  };

  config = lib.mkIf enableDocker {
    virtualisation.docker.enable = true;


    environment.systemPackages = with pkgs; [
      lazydocker
    ];
  };
}
