{
  config,
  pkgs,
  inputs,
  lib,
  services,
  ...
}:
let
  kmaps = import ./keymaps.nix { };
  plg = import ./plugins.nix { };
in
{
  # Sacar de Home Manager
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard.register = "unnamedplus";

    extraPlugins = with pkgs.vimPlugins; [
      cinnamon-nvim
      vim-be-good
      friendly-snippets
      whitespace-nvim
    ];

    colorschemes.onedark.enable = true;

    globals.mapleader = " ";

    plugins = plg;

    keymaps = kmaps;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

    extraConfigLua = ''
      require('cinnamon').setup {
        -- Enable all provided keymaps
        keymaps = {
          basic = true,
          extra = true,
        },
        -- Only scroll the window
        options = { mode = 'cursor' },
      }


      vim.opt.colorcolumn = "100"

      -- Define el resaltado para ColorColumn
      vim.cmd([[highlight ColorColumn ctermbg=235 guibg=#262626]])

      -- Crear autocmd para actualizar colorcolumn al cambiar de ventana
      vim.api.nvim_create_autocmd("WinLeave", {
        pattern = "*",
        callback = function()
          vim.opt.colorcolumn = "0"
        end,
      })

      vim.api.nvim_create_autocmd("WinEnter", {
        pattern = "*",
        callback = function()
          vim.opt.colorcolumn = "+0"
        end,
      })


        vim.api.nvim_set_hl(0, 'CmpItemAbbr', { fg = '#b0b0b0', bg = 'NONE' })
        vim.api.nvim_set_hl(0, "CmpSel", { bg = "#5f87af", fg = "#ffffff" })
    '';

  };
}
