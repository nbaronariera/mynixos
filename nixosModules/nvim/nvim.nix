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

    extraPlugins = with pkgs.vimPlugins; [
      cinnamon-nvim
    ];

    colorschemes.onedark.enable = true;

    globals.mapleader = " ";

    plugins = {
      lsp = {
        enable = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          jdtls = {
            enable = true;
          };
        };
      };

      ###
      #autocompletar
      ###

      gitsigns = {
        enable = true;
      };

      nvim-autopairs = {
        enable = true;
      };

      precognition = {
        enable = true;
      };

      toggleterm = {
        enable = true;
      };

      barbar = {
        enable = true;
      };

      treesitter = {
        enable = true;
        settings.indent.enable = true;
        settings.shighlight.enable = true;
      };

      cmp = {
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      which-key = {
        enable = true;
      };

      comment = {
        enable = true;
      };

      lualine = {
        enable = true;
      };

      ## Configurar
      #lazy = {
      #  enable = true;
      #};

      nvim-tree = {
        enable = true;
      };

      web-devicons = {
        enable = true;
      };

      telescope = {
        enable = true;
      };

    };

    keymaps = [
      # Activar Nvim Tree
      {
        key = "<leader>o";
        mode = "n";
        options.silent = true;
        action = ":NvimTreeToggle<CR>";
      }
      # Guardar archivo con Ctrl + s en modo normal e inserción
      {
        key = "<C-s>";
        action = ":update<CR>";
        mode = [ "n" ]; # 'n' para normal, 'i' para inserción
        options = {
          silent = true;
          desc = "Guardar archivo";
        };
      }

      # Cerrar ventana con Ctrl + q en modo normal
      {
        key = "<C-q>";
        action = ":q<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Cerrar la ventana";
        };
      }

      # Hace undo
      {
        key = "<C-z>";
        action = "u";
        mode = "n";
        options = {
          silent = true;
          desc = "Deshacer la acción";
        };
      }

      # Lanza terminal
      {
        key = "<leader><leader>t";
        action = ":ToggleTerm<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Lanzar terminal normal";
        };
      }

      # Lanza terminal flotante
      {
        key = "<leader><leader>f";
        action = ":ToggleTerm direction=float<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Lanzar terminal flotante";
        };
      }

      # Telescope busca ficheros
      {
        key = "<leader>ff";
        action = ":Telescope find_files<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Lanzar busqueda de ficheros";
        };
      }

      # Telescope live grep
      {
        key = "<leader>fg";
        action = ":Telescope live_grep<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Lanzar live grep";
        };
      }

      # Telescope buffers
      {
        key = "<leader>fb";
        action = ":Telescope buffers<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Lanzar buscador de buffers";
        };
      }

      # Telescope tags de ayuda
      {
        key = "<leader>fh";
        action = ":Telescope help_tags<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Lanzar las tags de ayuda";
        };
      }

    ];

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

    extraConfigLua = "require('cinnamon').setup {
      -- Enable all provided keymaps
      keymaps = {
          basic = true,
          extra = true,
      },
      -- Only scroll the window
      options = { mode = 'cursor' },
    }";
  };
}
