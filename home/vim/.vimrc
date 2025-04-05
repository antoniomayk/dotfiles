"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

syntax on

filetype on
filetype plugin on
filetype indent on

let mapleader=" "
let maplocalleader=" "

set nocompatible
set termguicolors
set clipboard=unnamedplus
set number
set relativenumber
set background=dark
set nocursorline
set nocursorcolumn
set fillchars+=vert:\│
set shiftwidth=4
set tabstop=4
set expandtab
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set timeoutlen=500
set undofile
set undodir=~/.vim/undo
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin()

" Fast, intuitive cursor movements.
Plug 'easymotion/vim-easymotion'
" Fuzzy finder core (Go).
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Fuzzy finder Vim integration.
Plug 'junegunn/fzf.vim'
" Easy text alignment.
Plug 'junegunn/vim-easy-align'
" Git diff markers in sign column.
Plug 'mhinz/vim-signify'
" Warm, retro Gruvbox colorscheme.
Plug 'morhetz/gruvbox'
" File tree explorer.
Plug 'preservim/nerdtree'
" Auto-close parentheses, brackets, quotes.
Plug 'jiangmiao/auto-pairs'
" File type icons.
Plug 'ryanoasis/vim-devicons'
" Language pack (syntax, indent, etc.).
Plug 'sheerun/vim-polyglot'
" Visual undo tree.
Plug 'simnalamburt/vim-mundo'
" Easy code commenting/uncommenting.
Plug 'tpope/vim-commentary'
" Unix-style Vim utilities.
Plug 'tpope/vim-eunuch'
" Git integration.
Plug 'tpope/vim-fugitive'
" Surround text objects (quotes, parens, etc.).
Plug 'tpope/vim-surround'
" Balanced line/buffer/window movement mappings.
Plug 'tpope/vim-unimpaired'
" Lean statusline/tabline.
Plug 'vim-airline/vim-airline'
" Incremental search.
Plug 'haya14busa/incsearch.vim'
" Easymotion integration for incremental search.
Plug 'haya14busa/incsearch-easymotion.vim'

call plug#end()

"----------------------------------------------------------
" VIM EASYMOTION
"----------------------------------------------------------

map <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

nmap s <Plug>(easymotion-overwin-f2)

map <leader>L <Plug>(easymotion-bd-jk)
nmap <leader>L <Plug>(easymotion-overwin-line)

map <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

"----------------------------------------------------------
" INCSEARCH
"----------------------------------------------------------

function! s:incsearch_config(...) abort
    return incsearch#util#deepextend(deepcopy({
    \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
    \   'keymap': {
    \     "\<cr>": '<Over>(easymotion)'
    \   },
    \   'is_expr': 0
    \ }), get(a:, 1, {}))
endfunction

"----------------------------------------------------------
" WEBDEVICONS
"----------------------------------------------------------

let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

if has('gui_running')
  let g:webdevicons_enable = 0
endif

"----------------------------------------------------------
" GRUVBOX
"----------------------------------------------------------

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'

colorscheme gruvbox 

"----------------------------------------------------------
" FZF
"----------------------------------------------------------

let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Label'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Label'],
    \ 'info':    ['fg', 'Comment'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Function'],
    \ 'pointer': ['fg', 'Statement'],
    \ 'marker':  ['fg', 'Conditional'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = {
    \ 'window': {
    \ 'width': 0.8,
    \ 'height': 0.6,
    \ 'x': 'center',
    \ 'y': 'center',
    \ 'border': 'sharp' } }

"----------------------------------------------------------
" NERD TREE
"----------------------------------------------------------

let NERDTreeMinimalUI=1

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 31

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"----------------------------------------------------------
" AIRLINE
"----------------------------------------------------------

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'

let g:airline_theme='gruvbox'

if !has('gui_running')
    let g:airline_powerline_fonts=1

    if !exists('g:airline_symbols')
        let g:airline_symbols={}
    endif

    let g:airline_left_sep=''
    let g:airline_left_alt_sep=''
    let g:airline_right_alt_sep=''
    let g:airline_symbols.linenr='␊'
    let g:airline_symbols.linenr='␤'
    let g:airline_symbols.branch=''
    let g:airline_symbols.dirty='⚡'
    let g:airline_symbols.readonly=''
    let g:airline_symbols.linenr='☰'
    let g:airline_symbols.maxlinenr=''
    let g:airline_symbols.paste='∥'
    let g:airline_symbols.whitespace='Ξ'
endif

let g:airline_section_x=''
let g:airline_section_z='%3p%% %l:%c'

" }}}

" MISC ------------------------------------------------------------------- {{{

"----------------------------------------------------------
" GUI
"----------------------------------------------------------

if has('gui_running')
  set ghr=0

  set guifont=JetBrainsMono\ Nerd\ Font\ 14
  set guioptions-=T
  set guioptions-=L
  set guioptions-=r
  set guioptions-=m
  set guioptions-=b

  nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
      \set guioptions-=mTr<Bar>
      \else<Bar>
      \set guioptions+=mTr<Bar>
      \endif<cr>
endif

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

inoremap jj <Esc>
inoremap kk <Esc>

nnoremap o o<esc>
nnoremap O O<esc>

nnoremap Y y$

noremap <c-w>+ :horizontal resize +5<cr>
noremap <c-w>- :horizontal resize -5<cr>
noremap <c-w>> :vertical resize +5<cr>
noremap <c-w>< :vertical resize -5<cr>

nnoremap <silent><esc><esc> :nohlsearch<cr>

nnoremap <leader>r :source $HOME/.vimrc<cr>

"----------------------------------------------------------
" NEO-TREE
"----------------------------------------------------------

""" NERDTree - Basic Commands (Prefix: <leader>n)
nnoremap <leader>n  :NERDTree<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFocus<cr>
nnoremap <leader>nc :NERDTreeClose<cr>
nnoremap <leader>nn :NERDTreeFind<cr>

""" NERDTree - VCS Variants (Prefix: <leader>nv)
nnoremap <leader>nv :NERDTreeVCS<cr>
nnoremap <leader>ntv :NERDTreeToggleVCS<cr>

""" NERDTree - Other Commands (Prefix: <leader>n + specific letter)
nnoremap <leader>nm :NERDTreeMirror<cr>
nnoremap <leader>nw :NERDTreeCWD<cr>
nnoremap <leader>nr :NERDTreeRefreshRoot<cr>

"----------------------------------------------------------
" INCSEARCH
"----------------------------------------------------------

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

"----------------------------------------------------------
" FZF
"----------------------------------------------------------

""" File Finding & Navigation (Prefix: <leader>f)
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fG :GFiles<cr>
nnoremap <leader>f? :GFiles?<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fc :Colors<cr>
nnoremap <leader>fl :Locate <C-r>=expand("<cword>")<cr><cr>
nnoremap <leader>fh :History<cr>
nnoremap <leader>f; :History:<cr>
nnoremap <leader>f/ :History/<cr>
nnoremap <leader>fT :Filetypes<cr>

""" Search (Prefix: <leader>/ or <leader>s)
nnoremap <leader>/a :Ag <C-r>=expand("<cword>")<cr><cr>
nnoremap <leader>/r :Rg <C-r>=expand("<cword>")<cr><cr>
nnoremap <leader>/* :RG <C-r>=expand("<cword>")<cr><cr>
nnoremap <leader>/l :Lines<cr>
nnoremap <leader>/bl :BLines<cr>

""" Tags (Prefix: <leader>t)
nnoremap <leader>tt :Tags<cr>
nnoremap <leader>tb :BTags<cr>

""" Git Commits (Prefix: <leader>gc)
nnoremap <leader>gc :Commits<cr>
nnoremap <leader>gbc :BCommits<cr>

""" Vim Information & Navigation (Prefix: <leader>v or <leader>w for window)
nnoremap <leader>vc :Changes<cr>
nnoremap <leader>vm :Marks<cr>
nnoremap <leader>vj :Jumps<cr>
nnoremap <leader>vw :Windows<cr>
nnoremap <leader>vs :Snippets<cr>

""" Vim Commands & Mappings (Prefix: <leader>:)
nnoremap <leader>:c :Commands<cr>
nnoremap <leader>:m :Maps<cr>
nnoremap <leader>:h :Helptags<cr>

" }}}
