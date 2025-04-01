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
      rebuild = "bash /home/nbr/Documentos/NixOs-Conf/rebuild.sh";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
      ];
      theme = "gnzh";
    };

    initExtra = "
      (cat ~/.cache/wal/sequences &)
      alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /yourpath/config:/.config/jesseduffield/lazydocker lazyteam/lazydocker'
    ";
  };
}
