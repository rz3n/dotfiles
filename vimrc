syntax on
set nocompatible
filetype off

set laststatus=2
set encoding=utf-8
set t_Co=256

set expandtab
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab
retab

" indentation settings
set autoindent
set copyindent
set nosmartindent
" set number		" line numbers

set rtp+=$HOME/.vim/bundle/powerline/bindings/vim/
" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'vundle.vim'


" All of your Plugins must be added before the following line
call vundle#end()			" required
filetype plugin indent on	" required

"
" https://github.com/vim-airline/vim-airline
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"let g:promptline_preset = {
"        \'a' : [ promptline#slices#host() ],
"        \'b' : [ promptline#slices#user() ],
"        \'c' : [ promptline#slices#cwd() ],
"        \'y' : [ promptline#slices#vcs_branch() ],
"        \'warn' : [ promptline#slices#last_exit_code() ]
"}

