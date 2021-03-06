set nocompatible
filetype off

" Bundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'mattn/emmet-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'othree/html5.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'davidhalter/jedi-vim'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdcommenter'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'editorconfig/editorconfig-vim'


" helpers

" presentation mode
" code from
" https://github.com/kaochenlong/eddie-vim/blob/master/plugin/settings/PresentationMode.vim
function! PresentationModeOn()
    set guifont=Monaco\ 25
endfunction

function! PresentationModeOff()
    set guifont=Monaco\ 11
endfunction

function! TogglePrestationMode()
    if !exists('w:presentation')
        let w:presentation=0
    endif

    if w:presentation==0
        call PresentationModeOn()
        let w:presentation=1
    else
        call PresentationModeOff()
        let w:presentation=0
    endif
endfunction


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
set wrap
set textwidth=79
set formatoptions=qrn1m
set colorcolumn=80
set foldmethod=indent
set hlsearch
set incsearch

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

" mapping
let mapleader = ','
let g:EasyMotion_leader_key = '<Leader>'
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
set nofoldenable
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
nnoremap <c-a> <c-w>
map <leader>P :call TogglePrestationMode()<CR>

" commands
nnoremap <leader>p vi(d<ESC>
nnoremap <leader>o F>l<ESC>dw<ESC>
inoremap <leader>i <ESC>viwU<ESC>ea

" resize buffer
if bufwinnr(1)
    nnoremap > <C-W>>
    nnoremap < <C-W><
    nnoremap + <C-W>+
    nnoremap - <C-W>-
endif


" plugin settings
let g:user_emmet_settings = {
\  'html' : {
\       'indentation' : '    '
\   },
\}

" handle some special cases...
au FileType html setl sw=4 sts=4 et colorcolumn=0
            \         guifont=WenQuanYi\ Micro\ Hei\ Mono\ 12
au FileType ejs setl sw=2 sts=2 et colorcolumn=0
au FileType htmldjango setl sw=4 sts=4 et colorcolumn=0
au FileType twig set ft=html
au FileType css setl sw=2 sts=2 et
au FileType less setl sw=2 sts=2 et
au FileType scss setl sw=2 sts=2 et
au FileType rml setl sw=2 sts=2 et colorcolumn=0
au FileType xml setl sw=4 sts=4 et colorcolumn=0
au FileType json setl sw=2 sts=2 et colorcolumn=0
au FileType pde setl sw=2 sts=2 et colorcolumn=79
au FileType markdown setl sw=2 sts=2 et colorcolumn=80 textwidth=80
            \             guifont=WenQuanYi\ Micro\ Hei\ Mono\ 12
au FileType sml setl sw=2 sts=2 et

" encoding guessing
" TODO reorder?
set fileencodings=utf-8,gbk,cp936

" syntastic
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'passive_filetypes': ['java'] }
let g:syntastic_python_checkers = ['flake8-python2', 'flake8']


" EOF
filetype plugin indent on
