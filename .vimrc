" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()
filetype plugin indent on

" EditorConfig
let g:EditorConfig_max_line_indicator = "none"

" Space and display tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Match indent of previous line
set autoindent

" Syntax highlighting
syntax on

" Save clicking Shift
nnoremap ; :

" Highlight search
set hlsearch

" Indent blocks of text in visual mode
vmap <TAB> >gv
vmap <BS> <gv

" Move between rows when soft wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Write using sudo trick
cmap w!! w !sudo tee % >/dev/null

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Paste across terminals
set clipboard^=unnamed

" Copy and paste with system clipboard
noremap y "+y
noremap Y "+Y
noremap p "+p
noremap P "+P

" Show hybrid line numbers
set number relativenumber
highlight LineNr ctermfg=None

" Colorscheme
colorscheme dracula
highlight Normal ctermfg=white ctermbg=black
