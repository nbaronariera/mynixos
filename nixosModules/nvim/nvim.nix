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
      friendly-snippets
    ];

    colorschemes.onedark.enable = true;

    globals.mapleader = " ";

    plugins = {
      lsp = {
        enable = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            settings.check.allTargets = false;
            cmd = [ "/run/current-system/sw/bin/rust-analyzer" ];
          };
          jdtls = {
            enable = true;
          };
        };
      };

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

      luasnip.enable = true;

      cmp-emoji = {
        enable = true;
      };

      cmp-nvim-lsp = {
        enable = true;
      };

      cmp-path = {
        enable = true;
      };

      cmp_luasnip = {
        enable = true;
      };

      cmp = {
        enable = true;

        settings = {
          experimental = {
            ghost_text = true;
          };
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            { name = "nvim_lua"; }
            { name = "path"; }
          ];

          formatting = {
            fields = [
              "abbr"
              "kind"
              "menu"
            ];
            format =
              # lua
              ''
                function(_, item)
                  local icons = {
                    Namespace = "󰌗",
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰆧",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈚",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "󰊄",
                    Table = "",
                    Object = "󰅩",
                    Tag = "",
                    Array = "[]",
                    Boolean = "",
                    Number = "",
                    Null = "󰟢",
                    String = "󰉿",
                    Calendar = "",
                    Watch = "󰥔",
                    Package = "",
                    Copilot = "",
                    Codeium = "",
                    TabNine = "",
                  }

                  local icon = icons[item.kind] or ""
                  item.kind = string.format("%s %s", icon, item.kind or "")
                  return item
                end
              '';
          };

          window = {
            completion = {
              winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
              scrollbar = false;
              sidePadding = 0;
              border = [
                "╭"
                "─"
                "╮"
                "│"
                "╯"
                "─"
                "╰"
                "│"
              ];
            };

            settings.documentation = {
              border = [
                "╭"
                "─"
                "╮"
                "│"
                "╯"
                "─"
                "╰"
                "│"
              ];
              winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
            };
          };

          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<S-Tab>" = "cmp.mapping.close()";
            "<Tab>" =
              # lua
              ''
                function(fallback)
                  local line = vim.api.nvim_get_current_line()
                  if line:match("^%s*$") then
                    fallback()
                  elseif cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                  else
                    fallback()
                  end
                end
              '';
            "<Down>" =
              # lua
              ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                  else
                    fallback()
                  end
                end
              '';
            "<Up>" =
              # lua
              ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                  else
                    fallback()
                  end
                end
              '';
          };
        };
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

      # Copia a mi clipboard
      {
        key = "<C-c>";
        action = ''"+y<CR>'';
        mode = "v";
        options = {
          silent = true;
          desc = "Copia el texto";
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

      # Mover al anterior buffer
      {
        key = "<C-,>";
        action = ":BufferPrevious<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Avanza al anterior buffer";
        };
      }

      # Mover al siguiente buffer
      {
        key = "<C-.>";
        action = ":BufferNext<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Avanza al siguiente buffer";
        };
      }

      # Mover el buffer a la izquierda
      {
        key = "<A-,>";
        action = ":BufferMovePrevious<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Avanza el buffer a la izquierda";
        };
      }

      # Mover el buffer a la derecha
      {
        key = "<A-.>";
        action = ":BufferMoveNext<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Avanza el buffer a la derecha";
        };
      }
    ];

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

            vim.api.nvim_set_hl(0, "CmpSel", { bg = "#5f87af", fg = "#ffffff" })

            --local ls = require("luasnip")
            --local s = ls.snippet
            --local t = ls.text_node

            -- Snippets personalizados
            --[[ ls.add_snippets("lua", {
              s("patata", {
                t({ 'print("patata")' }),
              }),
            }) ]]--
          }'';
  };
}
