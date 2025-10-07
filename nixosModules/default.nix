{ config, pkgs, ... }:
{
  imports = [
    ./gaming/steam.nix
    ./gaming/heroic.nix
    ./social/discord.nix
    ./programacion/git.nix
    ./programacion/nixfmt.nix
    ./programacion/virtualizacion.nix
    ./programacion/python.nix
    ./programacion/javascript.nix
    ./programacion/rust.nix
    ./programacion/rustrover.nix
    ./programacion/vscode.nix
    ./programacion/krita.nix
    ./programacion/java.nix
    ./programacion/android.nix
    ./programacion/docker.nix
    ./hyprland/cachix.nix
    ./hyprland/hyprlandModule.nix
    ./nvim/nvim.nix
  ];
}
