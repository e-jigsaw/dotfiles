# export path
export PATH=~/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/bin:$PATH
export PATH=${HOME}/.cabal/bin:$PATH

# color
autoload -Uz colors
colors

# git
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
export GIT_EDITOR=vim

# prompt
PROMPT="%F{green}%B%n@%m%b%f %F{yellow}%~ %1(v|%1v|)%f
%F{blue}%#%f "

# alias
alias g='git'
alias ls='ls -G'
alias la='ls -laG'
alias n='node'
alias h='heroku'
alias sb='open -a Sublime\ Text\ 2'
alias gr='grunt'
alias kitlogin='ssh -l 'b0122502' dhcpa.cis.kit.ac.jp'

# nvm
source ~/.nvm/nvm.sh
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir
nvm use default

# rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_reduce_blanks

# comp
autoload -Uz compinit
compinit
setopt auto_menu

# http://mimosa-pudica.net/zsh-incremental.html
source ${HOME}/dotfiles/incr*.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
source ${HOME}/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
