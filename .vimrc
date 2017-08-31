let mapleader = ","
let g:mapleader = ","

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'

call vundle#end()            " required
filetype plugin indent on    " required

set history=500
set number

set tabstop=4
set autoindent
" Always shows the current positions
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Config backspace so it acts as it should
set backspace=eol,start,indent

set ignorecase
set smartcase

set lazyredraw
set magic

set showmatch

" Remove the bell sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" https://github.com/rhysd/vim-color-spring-night
syntax enable
set t_Co=256
set background=dark
colorscheme spring-night
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile
set cmdheight=1
set relativenumber 
set number  
    
" Tabs are smarter!
set expandtab
set smarttab

" 1 Tab == 4 spaces
set shiftwidth=4
set tabstop=4

set lbr
set tw=500

set ai "auto indent
set si "smart indent
set wrap "wrap lines

" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
	 let old_query = getreg("/")
	 silent! %s/\s\+$\\e
	 call setpos('.', save_cursor)
	 call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt, *.js, *.py, *.wiki, *.sh, *.coffee :call CleanExtraSpaces()
endif 

" remap escape to caps lock
imap jj <Esc>  

" remap keys to change windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" alt-# to change tabs
nnoremap <A-F1> 1gt
nnoremap <A-F2> 2gt
nnoremap <A-F3> 3gt
nnoremap <A-F4> 4gt
nnoremap <A-F5> 5gt
nnoremap <A-F6> 6gt
nnoremap <A-F7> 7gt
nnoremap <A-F8> 8gt
nnoremap <A-F9> 9gt
nnoremap <A-F0> 10gt

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" Plugins

" NerdTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Ctr-p options
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Minimap
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'

" Airline
let g:airline#extensions#tabline#enabled = 1

" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
