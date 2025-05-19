-- Defines the space key as the global leader
vim.g.mapleader = " "
-- Defines the space key as the local leader
vim.g.maplocalleader = " "

-- Enables true colors in the terminal
vim.opt.termguicolors = true

-- Integrates the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Displays line numbers
vim.opt.number = true

-- Displays relative line numbers
vim.opt.relativenumber = true

-- Sets the background to dark
vim.opt.background = "dark"

-- Disables highlighting of the cursor line
vim.opt.cursorline = false

-- Disables highlighting of the cursor column
vim.opt.cursorcolumn = false

-- Displays the sign column for linters, etc.
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80,120"

-- Customizes characters for visual elements
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- Number of spaces for indentation (>>)
vim.opt.shiftwidth = 4

-- Tab width
vim.opt.tabstop = 4

-- Converts tabs to spaces
vim.opt.expandtab = true

-- Keeps space around the cursor during scrolling
vim.opt.scrolloff = 10

-- Disables automatic line wrapping
vim.opt.wrap = false

-- Shows search results while typing
vim.opt.incsearch = true

-- Ignores case in searches
vim.opt.ignorecase = true

-- Case-sensitive search if there's an uppercase letter
vim.opt.smartcase = true

-- Displays typed commands
vim.opt.showcmd = true

-- Displays the current mode
vim.opt.showmode = true

-- Always displays the status bar globally
vim.opt.laststatus = 3

-- Highlights matching characters (parentheses, braces, etc.)
vim.opt.showmatch = true

-- Keeps search highlighting
vim.opt.hlsearch = true

-- Time to complete mappings (ms)
vim.opt.timeoutlen = 500

-- Enable menu completion with no auto-insertion, a popup, and fuzzy matching.
vim.opt.completeopt = "menu,noinsert,popup,fuzzy"

-- Enables persistent undo
vim.opt.undofile = true

-- Directory for undo files
vim.opt.undodir = vim.fn.expand("~/.local/state/nvim/undo")

-- Enables the completion menu
vim.opt.wildmenu = true

-- Completion menu display mode
vim.opt.wildmode = "list:longest"

-- Ignores certain file types in completion
vim.opt.wildignore = vim.opt.wildignore + "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

vim.opt.foldmethod="marker"
