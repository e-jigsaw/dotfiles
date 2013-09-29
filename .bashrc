export PATH=~/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/bin:$PATH
export PATH=${HOME}/.cabal/bin:$PATH

alias g='git'
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias vi='vim'
alias n='node'
alias h='heroku'
alias sb='open -a Sublime\ Text\ 2'
alias gr='grunt'

export GIT_EDITOR=vim

alias kitlogin='ssh -l 'b0122502' dhcpa.cis.kit.ac.jp'

if [ -f $HOME/dotfiles/.git-completion.bash ]; then
    . $HOME/dotfiles/git-prompt.sh
    . $HOME/dotfiles/.git-completion.bash
fi

export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '

if [ -f $HOME/.nvm/nvm.sh ];then
	source ~/.nvm/nvm.sh
	npm_dir=${NVM_PATH}_modules
	export NODE_PATH=$npm_dir
	nvm use default
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
