syntax on
filetype indent plugin on

if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
endif

set nocompatible
set incsearch
set termguicolors
set hlsearch
set ruler
set ai
set wildmenu
set number
set path+=**
set backspace=indent,eol,start
set mouse=a
set clipboard+=unnamedplus
set nowrap
set scrolloff=5
set tabstop=4
set shiftwidth=4
set expandtab
set listchars=tab:»\ ,trail:·
set list
set colorcolumn=81

autocmd FileType gitcommit set textwidth=72 textwidth=73
autocmd FileType c         set colorcolumn=81 tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType cpp       set colorcolumn=101 tabstop=4 shiftwidth=4 expandtab
autocmd FileType rust      set colorcolumn=101 tabstop=4 shiftwidth=4 expandtab
autocmd FileType go        set colorcolumn=0 tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType make      set colorcolumn=81 tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType python    set colorcolumn=80 tabstop=4 shiftwidth=4 expandtab
autocmd FileType nix       set tabstop=2 shiftwidth=2 expandtab
" autocmd BufWritePre * :%s/\s\+$//e
