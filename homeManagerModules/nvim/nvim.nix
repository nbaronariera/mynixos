{
  config,
  pkgs,
  inputs,
  lib,
  services,
  ...
}
{
  programs.nixvim = {
    enable = true;

    colorschemes.catpuccine.enable = true;

    opts = {
        number = true;
        relativenumber= true;
        shiftwidth = 4;
    };
  };
}
