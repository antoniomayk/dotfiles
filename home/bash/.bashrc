PS1='\[\e[0;32m\]\u\[\e[0m\]@\[\e[0;35m\]\h \[\e[0m\]on \[\e[0;34m\]\w\n\[\e[0;33m\]$ \[\e[0m\]'

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups

shopt -s histappend

bind -s 'set completion-ignore-case on'

if [ -f ~/.bash_aliases ]; then
    . "$HOME/.bash_aliases"
fi

export EDITOR='vim'

eval "$(zoxide init bash)"
