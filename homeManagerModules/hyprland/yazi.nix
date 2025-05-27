{
  config,
  lib,
  pkgs,
  ...
}:
let
  enableYazi = config.my.enableYazi or false;
in
{
  options.my.enableYazi = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable yazi in the system";
  };

  config = lib.mkIf enableYazi {
    home.packages = with pkgs; [
      yazi
    ];

    xdg.configFile."yazi/yazi.toml".text = ''
      [manager]
      show_hidden = true

      [opener]

      kate = [
        {run = "kate $@", orphan = true, desc = "Use kate", for = "unix"},
      ]

      [open]
      rules = [
        "*.png"  = { run = ["imv", "$1"], block = false }
        "*.jpg"  = { run = ["imv", "$1"], block = false }
        "*.jpeg" = { run = ["imv", "$1"], block = false }
        "*.webp" = { run = ["imv", "$1"], block = false }
        "*.gif"  = { run = ["imv", "$1"], block = false }

        "*.mp4"  = { run = ["mpv", "$1"], block = false }
        "*.mkv"  = { run = ["mpv", "$1"], block = false }
        "*.webm" = { run = ["mpv", "$1"], block = false }

        "*.mp3"  = { run = ["mpv", "$1"], block = false }
        "*.flac" = { run = ["mpv", "$1"], block = false }
        "*.wav"  = { run = ["mpv", "$1"], block = false }

        "*.pdf"  = { run = ["okular", "$1"], block = false }

        "*.txt"  = { run = ["nvim", "$1"], block = true }
        "*.rs"   = { run = ["nvim", "$1"], block = true }
        "*.py"   = { run = ["nvim", "$1"], block = true }
        "*.md"   = { run = ["nvim", "$1"], block = true }

        "*.odt"   = { run = ["onlyoffice", "$1"], block = false }
        "*.docx"  = { run = ["onlyoffice", "$1"], block = false }
        "*.xlsx"  = { run = ["onlyoffice", "$1"], block = false }
        "*.pptx"  = { run = ["onlyoffice", "$1"], block = false }
      ]
    '';
  };
}
