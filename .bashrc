alias g='git'
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'

export GIT_EDITOR=vim

if [ -f $HOME/dotfiles/.git-completion.bash ]; then
    . $HOME/dotfiles/git-prompt.sh
    . $HOME/dotfiles/.git-completion.bash
fi

export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '

