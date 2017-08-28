set history=500
set number
syntax on
set tabstop=3
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

set mat=2

" Remove the bell sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldcolumn=1

syntax enable

" https://github.com/rhysd/vim-color-spring-night
colorscheme spring-night

set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile

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

