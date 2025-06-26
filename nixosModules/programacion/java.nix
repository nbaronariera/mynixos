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
      libGL
      xorg.libXxf86vm
      glib
      gtk3
      maven
    ];

    environment.variables.JAVA_HOME = "${pkgs.jdk23}/lib/openjdk";
    environment.variables.LD_LIBRARY_PATH = lib.mkForce "${pkgs.libGL}/lib:${pkgs.gtk3}/lib:${pkgs.glib.out}/lib:${pkgs.xorg.libXtst}/lib";
  };
}
