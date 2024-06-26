set autoread
set hidden
set nocompatible
filetype off

au CursorHold,CursorHoldI * checktime

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
set shell=zsh
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'towolf/vim-helm'
Plugin 'vim-airline/vim-airline'

call vundle#end()
filetype plugin indent on

" Dracula theme
let g:dracula_italic = 0
let g:dracula_colorterm = 0
colorscheme dracula

" EditorConfig
let g:EditorConfig_max_line_indicator = "none"

" FZF
set rtp+=/usr/local/opt/fzf

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

let $FZF_DEFAULT_COMMAND='fd --type f'

" Space and display tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Match indent of previous line
set autoindent
set smartindent

" Syntax highlighting
syntax on

" Ruler
set ruler

" Highlight search
set hlsearch
set ignorecase
set smartcase

" Line wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

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

" Paste across terminals
set clipboard^=unnamed

" Backspace, explicit for macOS
set backspace=indent,eol,start

" Copy and paste with system clipboard
"
"   This is for Visual mode, so you can highlight text and then yank it to the
"   system clipboard. You can also paste from the system clipboard in Visual
"   mode, or do the more common thing of going into Insert (Paste) and pasting.
if has("unix")

  let s:uname = substitute(system("uname -s"), "\n", "", "")

  " macOS
  if s:uname == "Darwin"

    vnoremap y "*y
    vnoremap Y "*Y
    vnoremap p "*p
    vnoremap P "*P

  " Linux
  elseif s:uname == "Linux"

    vnoremap y "+y
    vnoremap Y "+Y
    vnoremap p "+p
    vnoremap P "+P

  endif

endif

" Show hybrid line numbers
set number relativenumber
highlight LineNr ctermfg=None

" Move between buffers
map <C-Left> <Esc>:bprev<CR>
map <C-Right> <Esc>:bnext<CR>

" Move between splits
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Render Markdown preview
nnoremap <C-m> :MarkdownPreview<CR>
