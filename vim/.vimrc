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

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Reduce timeout len.
set timeoutlen=250

" Add clipboard support.
set clipboard=unnamedplus

" Add numbers to the file.
set number
set relativenumber

" Set the background tone.
set background=dark

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set nocursorcolumn

" Set space character for vertical border
set fillchars+=vert:\│

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'brooth/far.vim'

  Plug 'morhetz/gruvbox'

  Plug 'Donaldttt/fuzzyy'

  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

  Plug 'itchyny/lightline.vim'

  Plug 'tpope/vim-commentary'

  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  
  Plug 'tpope/vim-surround'

  Plug 'justinmk/vim-sneak'

call plug#end()

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Set the backslash as the leader key.
let mapleader = " "
let maplocalleader = " "

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Save current buffer.
nnoremap <leader>w :w<cr>

" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>p :%w !lp<CR>

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Press the space bar to type the : character in command mode.
nnoremap <\\> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

nnoremap <silent><esc><esc> :nohlsearch<CR>

" NERDTree specific mappings.
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>. :NERDTreeFind<CR>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

let NERDTreeMinimalUI=1

let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

" Grep string in project. if argument is given, it will search the <args>
nnoremap <leader>f :FuzzyGrep <C-R><C-W><CR>
" Search lines in current buffer. if argument is given, it will search the <args>
nnoremap <silent> <leader>fb :FuzzyInBuffer<CR>
" Search installed colorscheme
nnoremap <silent> <leader>fc :FuzzyColors<CR>
" Search :help documents
nnoremap <silent> <leader>fd :FuzzyHelps<CR>
" Search files in project
nnoremap <silent> <leader>ff :FuzzyFiles<CR>
" Search commands
nnoremap <silent> <leader>fi :FuzzyCommands<CR>
" Grep string in project. if argument is given, it will search the <args>
nnoremap <silent> <leader>fr :FuzzyGrep<CR>
" Search opened buffers
nnoremap <silent> <leader>ft :FuzzyBuffers<CR>
" Search highlights
nnoremap <silent> <leader>fh :FuzzyHighlights<CR>
" Search the most recent used files. set g:enable_fuzzyy_MRU_files = 1 to enable this command(not enable by default)
nnoremap <silent> <leader>fm :FuzzyMRUFiles<CR>

" Enables transparent background.
let g:gruvbox_transparent_bg='0'
" Changes dark mode contrast. Possible values are soft, medium and hard.
let g:gruvbox_contrast_dark='hard'

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

"Enables transparent background.
autocmd VimEnter * hi Normal ctermbg=none

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype vim setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
set undofile
set undoreload=10000

" Set the color scheme.
colorscheme gruvbox

" If GUI version of Vim is running set these options.
if has('gui_running')
    " Set a custom font you have installed on your computer.
    " Syntax: <font_name>\ <weight>\ <size>
    set guifont=JetBrains\ Mono\ 12

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the left-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>
endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif


" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

