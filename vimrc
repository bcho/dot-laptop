" BEGIN
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My bundles
" Install: :BundleInstall
Bundle 'mattn/zencoding-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'othree/html5.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'groenewege/vim-less'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'davidhalter/jedi-vim'
Bundle 'sophacles/vim-processing'
Bundle 'vim-scripts/fcitx.vim'
Bundle 'vim-scripts/cscope.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'esukram/vim-taglist'
Bundle 'scrooloose/nerdcommenter'
" Bundle 'kchmck/vim-coffee-script'

" basic settings
set modelines=0
set shiftwidth=4
set softtabstop=4
set expandtab
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set novisualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
" auto saving
" au FocusLost * :wa

" theme
set wrap
set textwidth=79
set formatoptions=qrn1m
set colorcolumn=80
" font
set guifont=Monaco\ 11
" color scheme
syntax enable
if has('gui_running')
    set background=dark
    colorscheme solarized
    let g:solarized_termcolors=256
else
    colorscheme desert
endif

set statusline=%l/%L
" toggle menu&toolbar
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
      \ set guioptions-=T <Bar>
      \ set guioptions-=m <bar>
      \ else <Bar>
      \ set guioptions+=T <Bar>
      \ set guioptions+=m <Bar>
      \ endif <CR>

" personal
let mapleader = ','
let g:EasyMotion_leader_key = '<Leader>'
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
set nofoldenable
" key mapping
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap jk <esc>
" inoremap <esc> <nop>
nnoremap <c-a> <c-w>

" command
nnoremap <leader>p vi(d<ESC>
nnoremap <leader>o F>l<ESC>dw<ESC>
nnoremap <leader>u viwU<ESC>e
inoremap <leader>u <ESC>viwU<ESC>ea
nnoremap <leader>m :w <BAR> !lessc static/css/style.less static/css/style.css<CR><space>
nnoremap <leader>c :TlistToggle<CR>

"   resize buffer
if bufwinnr(1)
    nnoremap > <C-W>>
    nnoremap < <C-W><
    nnoremap + <C-W>+
    nnoremap - <C-W>-
endif

" plugin
let g:user_zen_settings = {
\  'html' : {
\       'indentation' : '  '
\   },
\}

" indent
au FileType html setl sw=2 sts=2 et colorcolumn=0
au FileType htmldjango setl sw=2 sts=2 et colorcolumn=0
au FileType twig set ft=html
au FileType css setl sw=2 sts=2 et
au FileType less setl sw=2 sts=2 et
au FileType scss setl sw=2 sts=2 et
au FileType rml setl sw=2 sts=2 et colorcolumn=0
au FileType xml setl sw=4 sts=4 et colorcolumn=0
au FileType json setl sw=2 sts=2 et colorcolumn=0
au FileType pde setl sw=2 sts=2 et colorcolumn=79
au FileType php colorscheme evening

" END
filetype plugin indent on
