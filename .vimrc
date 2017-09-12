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
Plugin 'w0rp/ale'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'mkitt/tabline.vim'
Plugin 'mattn/emmet-vim'
Plugin 'atweiden/vim-dragvisuals'
Plugin 'flazz/vim-colorschemes'
Plugin 'tell-k/vim-autopep8'
Plugin 'jiangmiao/auto-pairs'
Plugin 'valloric/MatchTagAlways'
Plugin 'pangloss/vim-javascript'

" Tab navigation like Firefox.

call vundle#end()            " required
filetype plugin indent on    " required

set history=500
set number
set hlsearch

" Warning when lines are longer then 80 characters.
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Easier commands
nnoremap ; :

"nnoremap <silent> n n:call HLNext(0.4)<cr>
"nnoremap <silent> N N:call HLNext(0.4)<cr>
set so=7
set nocp
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
set cursorline
set t_Co=256
set background=light
colorscheme one 
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE

set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile

set relativenumber
set number

" Toggle Spellcheck
map <F6> :setlocal spell! spelllang=en_us<CR>

" Tabs are smarter!
set expandtab
set smarttab

" 1 Tab == 4 spaces
set shiftwidth=4
set tabstop=4

au FileType html setl sw=2 sts=2 et

set lbr
set tw=500

set ai "auto indent
set si "smart indent
set wrap "wrap lines

fun! <SID>StripTrailingWhitespaces()
        let l = line(".")
            let c = col(".")
                %s/\s\+$//e
                    call cursor(l, c)
                endfun

                autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

if has("autocmd")
    autocmd BufWritePre *.txt, *.js, *.py, *.wiki, *.sh, *.coffee :call CleanExtraSpaces()
endif 

" remap keys to change windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

inoremap j<Space> <Esc>/<++><Enter>"_d4li<Space>

autocmd FileType python nnoremap <leader>c oclass $name$(object):<Enter>def __init__(self):<Enter><++><Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>m odef $name$(self):<Enter><++><Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>f odef $name$():<Enter><++><Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>p o@property<Enter>def $name$(self):<Enter><++><Esc>?$name<Enter>ct(

for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

nnoremap <C-l> :tabnext<CR> 
nnoremap <C-h> :tabprevious<CR> 
nnoremap <C-Left>  :-tabmove<cr>
nnoremap <C-Right> :+tabmove<cr>

" Plugins

" MatchTagAlways
let g:mta_use_matchparen_group = 1

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
set completeopt-=preview
" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1

" Flake8 autoformater
let g:autopep8_disable_show_diff=1
autocmd BufWritePost *.py call Autopep8()


" visualdrag keys
vmap <expr> <LEFT> DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN> DVB_Drag('down')
vmap <expr> <UP> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

let g:DVB_TrimWS = 1

" only use emmet on correct file types
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall


" NerdTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Ctr-p options
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_root_markers = ['hyp3-time-series', 'hyp3-api']
let g:ctrlp_working_path_mode = 'ra'

" Minimap
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="base16"

" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
