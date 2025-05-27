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
      [rules]
      "*" = { run = ["xdg-open", "$1"], block = false }
    '';
  };
}
