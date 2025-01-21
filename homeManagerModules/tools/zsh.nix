{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable = true;
      highlight = "fg=#6f6c5d";
    };
    history = {
      path = "$HOME/.histfile";
      save = 10000;
      size = 10000;
    };

    shellAliases = {
      ll = "ls -l";
      rebuild = "~/rebuild.sh";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
      ];
      theme = "gnzh";
    };
  };
}
