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
PROMPT="%F{green}[%D{%T}] %B%n@%m%b%f %F{yellow}%~ %1 %F{blue}%(v|%1v|)%f
%F{magenta}✈%f "

# show current directory on tab
echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"

# display
zstyle ':completion:*' list-separator '-->'

# vi mode
bindkey -v
function zle-line-init zle-keymap-select {
  vimode="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"
  if [ -n "$TMUX" ]; then
    if [ $vimode = "NORMAL" ]; then
      modebg="colour45"
      modefg="colour15"
    else
      modebg="colour202"
      modefg="colour255"
    fi
    tmux set -g status-left "#[bg=${modebg}, fg=${modefg}] $vimode " > /dev/null
  fi
}
zle -N zle-line-init
zle -N zle-keymap-select

# alias
alias g='git'
alias gs='git st'
alias ggr='git gr'
alias ls='ls -G'
alias la='ls -laG'
alias n='node'
alias h='heroku'
alias a='open -a Atom'
alias bi='bundle install'
alias be='bundle exec'
alias gh='gh-open'
alias gho='gh-open $(ghq list -p | peco)'
alias ga='open -a Atom $(ghq list -p | peco)'
alias jk='journal write'
alias jc='journal comment'
alias js='journal send'
alias up='cd ../'
alias upp='cd ../../'
alias o='open'
alias t='tmux'
alias bf='brew file'
alias bfe='brew file edit'
alias bfi='brew file install'

## global
alias -g @l='| less'
alias -g @p='| peco'
alias -g @c='| pbcopy'
alias -g @gb='`git branch | peco | sed -e "s/^\*[ ]*//g"`'
alias -g @gf='`git status --porcelain | peco | sed -e "s/^.. //g"`'
alias -g @gl='`git log --oneline | peco | cut -d" " -f1`'

## suffix
alias -s coffee='coffee'

bindkey '^E^E' beginning-of-line

# peco cd
function _peco_cd() {
  BUFFER="cd $(ghq list --full-path | peco)"
  CURSOR=$#BUFFER
  zle accept-line
}

zle -N peco-cd _peco_cd
bindkey '^F' peco-cd

# peco bck-i-search
function peco-select-history() {
  typeset tac
  if which tac > /dev/null; then
    tac=tac
  else
    tac='tail -r'
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
}
zle -N peco-select-history
stty -ixon
bindkey '^r' peco-select-history

# git bind
function _git_st() {
  BUFFER="git status --branch --short"
  CURSOR=$#BUFFER
  zle accept-line
}

zle -N git-st _git_st
bindkey '^g^[[B' git-st

# open bind
function _open_atom() {
  BUFFER="open -a Atom ."
  CURSOR=$#BUFFER
  zle accept-line
}

zle -N open-atom _open_atom
bindkey '^o^[[D' open-atom

function _open_finder() {
  BUFFER="open ."
  CURSOR=$#BUFFER
  zle accept-line
}
zle -N open-finder _open_finder
bindkey '^o^f' open-finder

function _open_tmux() {
  BUFFER="tmux"
  CURSOR=$#BUFFER
  zle accept-line
}
zle -N open-tmux _open_tmux
bindkey '^t' open-tmux

# nvm
if [ -f $HOME/.nvm/nvm.sh ]; then
  source ~/.nvm/nvm.sh
  npm_dir=${NVM_PATH}_modules
  export NODE_PATH=$npm_dir
fi

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# go
export GOPATH=~/.ghq
export PATH=$PATH:~/.ghq/bin

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_reduce_blanks

# comp
autoload -Uz compinit && compinit -u
setopt menu_complete

# util
function cd() {
  builtin cd $@ && ls -a && echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007";
}

# http://mimosa-pudica.net/zsh-incremental.html
source ${HOME}/.ghq/src/github.com/e-jigsaw/dotfiles/incr*.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
source ${HOME}/.ghq/src/github.com/e-jigsaw/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-completions
fpath=(${HOME}/.ghq/src/github.com/e-jigsaw/dotfiles/zsh-completions/src $fpath)

# https://github.com/rupa/z
if [ -f /usr/local/etc/profile.d/z.sh ]; then
  source /usr/local/etc/profile.d/z.sh
fi

# awscli

if [ -f /usr/local/share/zsh/site-functions/_aws ]; then
  source /usr/local/share/zsh/site-functions/_aws
fi
