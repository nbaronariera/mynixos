{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableJava = config.my.enableJava or false;
in
{
  options.my.enableJava = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable java in the system";
  };

  config = lib.mkIf enableJava {
    programs.java = {
      enable = true;
      package = (pkgs.jdk23.override { enableJavaFX = true; });
    };

    environment.systemPackages = with pkgs; [
      javaPackages.openjfx23
      javaPackages.openjfx17
      libGL
      xorg.libXxf86vm
      glib
      gtk3
      maven
      gradle
      android-studio
      jetbrains.idea-ultimate
    ];

    nixpkgs.config.android_sdk.accept_license = true;

    environment.variables.JAVA_HOME = "${pkgs.javaPackages.openjfx17}/lib/openjdk";
    environment.variables.LD_LIBRARY_PATH = lib.mkForce "${pkgs.libGL}/lib:${pkgs.gtk3}/lib:${pkgs.glib.out}/lib:${pkgs.xorg.libXtst}/lib";
  };
}
