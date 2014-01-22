# export path
# export PATH=~/.cabal/bin:$PATH

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
%F{blue}✈%f "

# display
zstyle ':completion:*' list-separator '-->'

# alias
alias g='git'
alias gs='git status'
alias ls='ls -G'
alias la='ls -laG'
alias n='node'
alias h='heroku'
alias sb='open -a Sublime\ Text\ 2'
alias mou='open -a Mou'
alias gr='grunt'
alias bi='bundle install'
alias be='bundle exec'
alias kitlogin='ssh -l 'b0122502' dhcpa.cis.kit.ac.jp'

# nvm
if [ -f $HOME/.nvm/nvm.sh ]; then
	source ~/.nvm/nvm.sh
	npm_dir=${NVM_PATH}_modules
	export NODE_PATH=$npm_dir
	nvm use default
fi

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

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

# util
function cd() {
	builtin cd $@ && ls -a;
}

# http://mimosa-pudica.net/zsh-incremental.html
source ${HOME}/dotfiles/incr*.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
source ${HOME}/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-completions
fpath=(${HOME}/dotfiles/zsh-completions/src $fpath)
