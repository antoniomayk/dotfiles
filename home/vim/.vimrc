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
set undodir=~/.vim/undo
set undofile
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" PLUGINS ---------------------------------------------------------------- {{{

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'

colorscheme gruvbox 

hi Normal guibg=#000000 ctermbg=0
hi VertSplit guibg=#000000 ctermbg=0
hi Folded guibg=#000000 ctermbg=0
hi IncSearch guibg=#000000 ctermbg=0
hi LineNr guibg=#000000 ctermbg=0
hi CursorLineNr guibg=#000000 ctermbg=0
hi StatusLine guibg=#000000 ctermbg=0
hi StatusLineNC guibg=#000000 ctermbg=0
hi Pmenu guibg=#000000 ctermbg=0
hi PmenuSel guibg=#000000 ctermbg=0
hi TabLineFill guibg=#000000 ctermbg=0
hi TabLineSel guibg=#000000 ctermbg=0
hi TabLine guibg=#000000 ctermbg=0

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

autocmd VimEnter * if !argc() | Explore | endif

autocmd VimEnter * if isdirectory(expand('<afile>')) | Explore | endif

let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 3
let g:netrw_sort_options = 'i'

autocmd FileType netrw setlocal statusline=\ Netrw

if &term =~ "screen."
    let &t_ti.="\eP\e[1 q\e\\"
    let &t_SI.="\eP\e[5 q\e\\"
    let &t_EI.="\eP\e[1 q\e\\"
    let &t_te.="\eP\e[0 q\e\\"
else
    let &t_ti.="\<Esc>[1 q"
    let &t_SI.="\<Esc>[5 q"
    let &t_EI.="\<Esc>[1 q"
    let &t_te.="\<Esc>[0 q"
endif

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

noremap <c-w>+ :horizontal resize +5<cr>
noremap <c-w>- :horizontal resize -5<cr>
noremap <c-w>> :vertical resize +5<cr>
noremap <c-w>< :vertical resize -5<cr>

nnoremap <silent><esc> :nohlsearch<cr>

nnoremap <leader>r :source $HOME/.vimrc<cr>

nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>
nnoremap <leader>bd :bdelete<cr>  
nnoremap <leader>ba :wa<cr>  

nnoremap <leader>ee :Explore<cr>

" }}}
