require("options")
require("config.lazy")
require("config.cmp")
require("config.mason")
require("mappings")

require("lsp.lua_ls")
require("lsp.bashls")

vim.cmd("colorscheme catppuccin-mocha")

if vim.g.neovide then require("ginit") end

