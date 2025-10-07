{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableAndroid = config.my.enableAndroid or false;
in
{
  options.my.enableAndroid = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable android in the system";
  };

  config = lib.mkIf enableAndroid {
    environment.systemPackages = with pkgs; [
      android-studio-full
      android-tools
    ];

    nixpkgs.config.android_sdk.accept_license = true;
  };
}
