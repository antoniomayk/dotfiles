-- vim

local fn = vim.fn
local g = vim.g
local opt = vim.opt

--=========================================================
--= common
--=========================================================

g.mapleader = " "
g.maplocalleader = " "
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.background = "dark"
opt.cursorline = false
opt.cursorcolumn = false
opt.signcolumn = "yes"
opt.colorcolumn = "80,120"
opt.fillchars = {
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vert = "│",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
}
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.scrolloff = 10
opt.wrap = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showcmd = true
opt.showmode = true
opt.laststatus = 3
opt.showmatch = true
opt.hlsearch = true
opt.timeoutlen = 250
opt.completeopt = "menu,noinsert,popup,fuzzy"
opt.undofile = true
opt.undodir = fn.expand("~/.local/state/nvim/undo")
opt.wildmenu = true
opt.wildmode = "list:longest"
opt.wildignore = opt.wildignore + "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"
opt.foldmethod = "marker"
