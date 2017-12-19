let mapleader = ","
let g:mapleader = ","

set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Core Plugins
Plugin 'w0rp/ale'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" Quality of Life
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'

" GUI Improvements
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'

" HTML
Plugin 'mattn/emmet-vim'
Plugin 'alvan/vim-closetag'
Plugin 'valloric/MatchTagAlways'

" CSS
Plugin 'ap/vim-css-color'

" JS/TS
Plugin 'pangloss/vim-javascript'
Plugin 'Galooshi/vim-import-js'
Plugin 'leafgarland/typescript-vim'

" GLSL
Plugin 'tikhomirov/vim-glsl'

"Python
Plugin 'tell-k/vim-autopep8'

call vundle#end()            " required
filetype plugin indent on    " required

runtime macros/matchit.vim

nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

" Moving tabs
nnoremap <leader>h  :-tabmove<CR>
nnoremap <leader>l :+tabmove<CR>

" Saving
nnoremap <leader>w :w<Enter>
nnoremap <leader>q :wq<Enter>
nnoremap <leader>Q :q<Enter>
nnoremap <leader>ct :wall<Enter>:tabonly<Enter>:tabnew<Enter>gT:wq<Enter>
nnoremap <leader>z :wall<Enter>:qall<Enter>

nnoremap <leader>r :noh<Enter>

vnoremap <leader>y "+y
nnoremap <leader>v "+p

nnoremap <leader><Space> o<Esc>k

set history=500
set number
set hlsearch

autocmd InsertEnter * :let b:_search=@/|let @/=''
autocmd InsertLeave * :let @/=get(b:,'_search','')

set autochdir

" Warning when lines are longer then 80 characters.
highlight ColorColumn ctermbg=253
call matchadd('ColorColumn', '\%81v', 100)

set so=5
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

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
"
" 1 Tab == 4 spaces
set shiftwidth=4
set tabstop=4

au FileType html setl sw=2 sts=2 et

set lbr
set tw=500

set ai "auto indent
set si "smart indent
set wrap "wrap lines


autocmd FileType yaml nnoremap <leader>n CClass:<Space><Enter>Name:<Space>William<Space>Horn<Enter><Esc>:put<Space>=strftime('%b %d, %Y')<Enter>kddIDate:<Space><Esc>kk0f:a<Space>

" Python snippets
autocmd FileType python nnoremap <leader>mc oclass<Space>$name$(object):<Enter>def<Space>__init__(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mm odef<Space>$name$(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mf odef<Space>$name$():<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mp o@property<Enter>def $name$(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>ma o@abstractmethod<Enter>def $name$(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mn oif<Space>__name__<Space>==<Space>"__main__":<Enter>pass<Esc>b
autocmd FileType python nnoremap <leader>s. iself.<Esc>

for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

" Plugins

" MatchTagAlways
let g:mta_use_matchparen_group = 1

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
set completeopt-=preview
"
" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

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

" filenames like *.xml, *.html, *.xhtml, ...
" Then after you press <kbd>&gt;</kbd> in these files, this plugin will try to close the current tag.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non closing tags self closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" integer value [0|1]
" This will make the list of non closing tags case sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" NerdCommentor
let g:NERDDefaultAlign = 'left'

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Ctr-p options
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

nnoremap <leader>t :CtrlPTag<cr>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="base16"
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#fnamemod = ':t'

" glsl syntax
let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.vert,*.tesc,*.tese,*.geom,*.frag,*.comp'

" Whitespace plugin
highlight ExtraWhitespace ctermbg=253
autocmd BufEnter * EnableStripWhitespaceOnSave

" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
