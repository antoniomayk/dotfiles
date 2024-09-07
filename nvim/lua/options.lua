--
-- IMPORTS
--

local opt = vim.opt
local o = vim.o
local g = vim.g
local wo = vim.wo
local api = vim.api

--
-- OPTIONS
--

o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "both"

o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true
o.numberwidth = 2
o.ruler = false
o.colorcolumn = "80"

opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

o.updatetime = 250

o.shell = "fish"

opt.whichwrap:append("<>[]hl")

wo.wrap = false

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.mapleader = " "
g.maplocalleader = "\\"

