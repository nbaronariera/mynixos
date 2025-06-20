{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableRust = config.my.enableRust or false;
in
{
  options.my.enableRust = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable rust in the system";
  };

  config = lib.mkIf enableRust {
    environment.variables.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    environment.variables.LIBCLANG_PATH = "${pkgs.llvmPackages.libclang}/lib";

    environment.systemPackages = with pkgs; [
      cargo
      rustc
      gcc
      cargo-generate
      cargo-llvm-cov
      rustup
      rust-analyzer
      gnuplot
      rustfmt
      bacon
      llvmPackages.libclang
      llvmPackages.clang
    ];
  };
}
