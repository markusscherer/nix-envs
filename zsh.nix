with (import <nixpkgs> {});
mkShell rec {
  buildInputs = [
    zsh
    oh-my-zsh
    autojump
    fzf
  ];

  zdotdir = writeTextFile {
    name = "zshrc";
    text = ''
    ZSH_THEME="ys"
    export ZSH="${oh-my-zsh}/share/oh-my-zsh/"
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

    source ${autojump}/share/autojump/autojump.zsh
    '';
    destination = "/.zshrc";
  };

  shellHook = ''
    ZDOTDIR=${zdotdir} zsh
    exit
  '';
}
