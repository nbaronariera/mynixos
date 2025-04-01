{ config, pkgs, ... }:
{
  imports = [
    ./hyprland/bundle.nix
    ./tools/zsh.nix
    ./nvim/nvim.nix
  ];
}
