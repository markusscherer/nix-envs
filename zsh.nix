with (import <nixpkgs> {});
mkShell rec {
  buildInputs = [
    zsh
    oh-my-zsh
    autojump
  ];

  zdotdir = writeTextFile {
    name = "zshrc";
    text = ''
    ZSH_THEME="ys"
    source $ZSH/oh-my-zsh.sh

    HISTFILE=~/.zsh_history
    HISTSIZE=40000
    SAVEHIST=40000
    
    setopt appendhistory
    setopt sharehistory
    setopt hist_ignore_space
    
    autoload zmv

    if [ -n "''${commands[fzf-share]}" ]; then
      source "$(fzf-share)/key-bindings.zsh"
    fi

    # I bet there's a way to make this more elegant...
    source $(dirname $(dirname $(readlink -f $(which autojump))))/share/autojump/autojump.zsh
    '';
    destination = "/.zshrc";
  };

  shellHook = ''
    ZDOTDIR=${zdotdir} zsh
    exit
  '';
}
