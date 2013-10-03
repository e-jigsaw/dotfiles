set nocompatible 

" # 検索
" ## 大文字小文字を区別しない, 大文字小文字が両方含まれている場合は区別する
set ignorecase
set smartcase

" ## 強調表示
set hlsearch

" # 表示
" ## 行番号表示
set number

" ## カーソル位置
set ruler

" ## カーソル行ハイライト
set cursorline

" ## ステータス行
set laststatus=2

" ## 括弧の対応表示
set showmatch

" ## スクロール時の視界
set scrolloff=16

" ## シンタックスハイライト
syntax on

" # tab & indent
" ## tab を space に置換
set expandtab

" ## オートインデント
set autoindent
set smartindent

" ## タブ幅
set tabstop=2
set shiftwidth=2
set softtabstop=2

" # Coffeescript
" ## syntax
source $HOME/dotfiles/vim-coffee-script/syntax/coffee.vim

" ## indent
source $HOME/dotfiles/vim-coffee-script/indent/coffee.vim

