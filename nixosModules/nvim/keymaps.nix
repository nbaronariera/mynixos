{ ... }:
{
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
}
