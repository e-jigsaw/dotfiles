set nocompatible

" # bundle 下のモジュール読み込み
set runtimepath+=~/.vim/bundle/vim-coffee-script
set runtimepath+=~/.vim/bundle/nerdtree
set runtimepath+=~/.vim/bundle/neocomplcache.vim

" # neocomplcache.vim
" ## Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" ## Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

" ## Use smartcase.
let g:neocomplcache_enable_smart_case = 1

" ## Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

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

" # キーバインド
" ## NERDTree
nnoremap <C-t> :NERDTreeToggle<Enter>
