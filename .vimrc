let mapleader = ","
let g:mapleader = ","

set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8

source ~/.vim/plugins.vim

" Key Bindings

nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

nnoremap <C-k> :bnext<CR>
nnoremap <C-j> :bprevious<CR>

" Moving tab order
nnoremap <leader>h  :-tabmove<CR>
nnoremap <leader>l :+tabmove<CR>

nnoremap <C-x>h :wincmd h<CR>
nnoremap <C-x>l :wincmd l<CR>
nnoremap <C-x>k :wincmd k<CR>
nnoremap <C-x>j :wincmd j<CR>

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

" Notes header
autocmd FileType yaml nnoremap <leader>n CClass:<Space><Enter>Name:<Space>William<Space>Horn<Enter><Esc>:put<Space>=strftime('%b %d, %Y')<Enter>kddIDate:<Space><Esc>kk0f:<Space>:r !cat ../class.conf<Enter>kJ3jo<Enter><Esc>
"
" Python snippets
autocmd FileType python nnoremap <leader>mc oclass<Space>$name$(object):<Enter>def<Space>__init__(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mm odef<Space>$name$(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mf odef<Space>$name$():<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mp o@property<Enter>def $name$(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>ma o@abstractmethod<Enter>def $name$(self):<Enter>pass<Esc>?$name<Enter>ct(
autocmd FileType python nnoremap <leader>mn oif<Space>__name__<Space>==<Space>"__main__":<Enter>pass<Esc>b
autocmd FileType python nnoremap <leader>s. iself.<Esc>

" Toggle Spellcheck
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" Vim Settings
set history=500
set number
set hlsearch
set updatetime=100

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


" Tabs are smarter!
set expandtab
set smarttab

" Enable folding
set foldmethod=indent
set foldlevel=99

" 1 Tab == 4 spaces
set shiftwidth=4
set tabstop=4

au FileType html setl sw=2 sts=2 et
au FileType css setl sw=2 sts=2 et
au FileType scss setl sw=2 sts=2 et

set lbr
set tw=500

set ai "auto indent
set si "smart indent
set wrap "wrap lines

for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

