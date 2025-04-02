{
  config,
  pkgs,
  inputs,
  lib,
  services,
  ...
}:
{
  # Sacar de Home Manager
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      lsp = {
        enable = true;
        servers = {
          rust_analyzer.enable = true;
        };
      };

      treesitter = {
        enable = true;
        indent = true;
      };

    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

  };
}
