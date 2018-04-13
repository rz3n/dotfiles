syntax on
set nocompatible
filetype off

set laststatus=2
set encoding=utf-8
set t_Co=256

set tabstop=4
set shiftwidth=4

" indentation settings
set autoindent
set copyindent
set nosmartindent
" set number    " line numbers

let g:airline_theme='dark'

set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins
"Plugin 'gmarik/vundle'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vundle.vim'


" All of your Plugins must be added before the following line
call vundle#end()       " required
filetype plugin indent on " required
