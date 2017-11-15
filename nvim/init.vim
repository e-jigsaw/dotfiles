if &compatible
  set nocompatible
endif

let g:python3_host_prog = '/usr/bin/python3'

let s:dein_cache_path = expand('~/.cache/nvim/dein')
set runtimepath^=~/.ghq/github.com/Shougo/dein.vim

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein.lazy.toml', {'lazy' : 1})
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

runtime! options.vim

