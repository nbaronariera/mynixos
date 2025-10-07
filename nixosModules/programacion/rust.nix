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

    environment.systemPackages = with pkgs; [
      cargo
      rustc
      gcc
      cargo-generate
      rust-analyzer
      rustfmt
      clippy
      dioxus-cli
      rustfmt
      direnv
      nix-direnv
    ];
  };
}
