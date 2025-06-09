-- vim

local cmd = vim.cmd
local diagnostic = vim.diagnostic
local fn = vim.fn
local lsp = vim.lsp.buf
local map = vim.keymap.set
local treesitter = vim.treesitter

-- snacks

local snacks = require("snacks")
local picker = snacks.picker

--=========================================================
--= misc
--=========================================================

-- stylua: ignore start
map({ "i" }, "jj", "<Esc>", { noremap = true, silent = true, desc = "jj to Escape" })
map({ "i" }, "kk", "<Esc>", { noremap = true, silent = true, desc = "kk to Escape" })
map({ "n" }, "Y", "y$", { noremap = true, silent = true, desc = "Yank to end of line" })
map({ "n" }, "<C-s>", ":w<CR>", { desc = "Save current file" })
map({ "i" }, "<C-s>", "<Esc>:w<CR>a", { desc = "Save current file" })
map({ "n" }, "<C-S-s>", ":wa<CR>", { desc = "Save all files" })
map({ "i" }, "<C-S-s>", "<Esc>:wa<CR>a", { desc = "Save all files" })
map({ "n", "t", "i" }, "<c-/>", function() snacks.terminal() end, { desc = "Open terminal" })
map({ "n", "v", "o" }, "<c-w>+", ":horizontal resize +5<CR>", { noremap = true, silent = true })
map({ "n", "v", "o" }, "<c-w>-", ":horizontal resize -5<CR>", { noremap = true, silent = true })
map({ "n", "v", "o" }, "<c-w>>", ":vertical resize +5<CR>", { noremap = true, silent = true })
map({ "n", "v", "o" }, "<c-w><", ":vertical resize -5<CR>", { noremap = true, silent = true })
map({ "n" }, "<esc>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })
-- stylua: ignore end

--=========================================================
--= conform
--=========================================================

-- stylua: ignore start
map({ "n", "v" }, "=", function() require("conform").format({ async = true }) end, { desc = "Format selection (LSP)" })
-- stylua: ignore end

--=========================================================
--= flash
--=========================================================

-- stylua: ignore start
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
map({ "o" }, "r", function() require("flash").remote() end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
-- stylua: ignore end

--=========================================================
--= grugfar
--=========================================================

vim.keymap.set({ "n", "v" }, "<C-S-/>", function()
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  require("grug-far").open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Search and Replace" })

--=========================================================
--= unimpaired
--=========================================================

-- stylua: ignore start
map({ "n" }, "]d", function() diagnostic.jump({ count = 1 }) end, { desc = "Go to next diagnostic" })
map({ "n" }, "[d", function() diagnostic.jump({ count = -1 }) end, { desc = "Go to previous diagnostic" })
map({ "n" }, "]f", function() treesitter.get_captures_at_cursor() fn.search("@function.outer", "W") cmd("normal! zz") end, { desc = "Go to next function (TS)" })
map({ "n" }, "[f", function() treesitter.get_captures_at_cursor() fn.search("@function.outer", "bW") cmd("normal! zz") end, { desc = "Go to previous function (TS)" })
map({ "n" }, "]t", function() fn.search("@type.outer", "W") cmd("normal! zz") end, { desc = "Go to next type definition (TS)" })
map({ "n" }, "[t", function() fn.search("@type.outer", "bW") cmd("normal! zz") end, { desc = "Go to previous type definition (TS)" })
map({ "n" }, "]a", function() fn.search("@parameter.inner", "W") cmd("normal! zz") end, { desc = "Go to next argument/parameter (TS)" })
map({ "n" }, "[a", function() fn.search("@parameter.inner", "bW") cmd("normal! zz") end, { desc = "Go to previous argument/parameter (TS)" })
map({ "n" }, "]c", function() fn.search("@comment.outer", "W") cmd("normal! zz") end, { desc = "Go to next comment (TS)" })
map({ "n" }, "[c", function() fn.search("@comment.outer", "bW") cmd("normal! zz") end, { desc = "Go to previous comment (TS)" })
map({ "n" }, "]T", function() fn.search("@test.outer", "W") end, { desc = "Go to next test (TS)" })
map({ "n" }, "[T", function() fn.search("@test.outer", "bW") end, { desc = "Go to previous test (TS)" })
map({ "n" }, "]p", "}", { desc = "Go to next paragraph" })
map({ "n" }, "[p", "{", { desc = "Go to previous paragraph" })
map({ "n" }, "]<space>", "o<Esc>", { desc = "Add newline below" })
map({ "n" }, "[<space>", "O<Esc>", { desc = "Add newline above" })
-- stylua: ignore end

--=========================================================
--= space mode
--=========================================================

-- stylua: ignore start
map({ "n" }, "<leader>e", function() snacks.explorer() end, { desc = "Open file explorer" })
map({ "n" }, "<leader>f", function() picker.files() end, { desc = "Open file picker" })
map({ "n" }, "<leader>g", function() snacks.lazygit() end, { desc = "Open git explorer" })
map({ "n" }, "<leader>b", function() picker.buffers() end, { desc = "Open buffer picker" })
map({ "n" }, "<leader>-", function() snacks.bufdelete() end, { desc = "Close buffer" })
map({ "n" }, "<leader>_", function() snacks.bufdelete.other() end, { desc = "Close other buffers" })
map({ "n" }, "<leader>j", function() picker.jumps() end, { desc = "Open jumplist picker" })
map({ "n" }, "<leader>s", function() picker.lsp_symbols() end, { desc = "Open symbol picker" })
map({ "n" }, "<leader>S", function() picker.lsp_workspace_symbols() end, { desc = "Open workspace symbol picker" })
map({ "n" }, "<leader>d", function() picker.diagnostics_buffer() end, { desc = "Open diagnostic picker" })
map({ "n" }, "<leader>D", function() picker.diagnostics() end, { desc = "Open workspace diagnostic picker" })
map({ "n" }, "<leader>D", function() picker.diagnostics() end, { desc = "Open workspace diagnostic picker" })
map({ "n", "v" }, "<leader>a", lsp.code_action, { desc = "Peform code action" })
map({ "n" }, "<leader>'", function() picker.resume() end, { desc = "Open last picker" })
map({ "n" }, "<leader>/", function() picker.grep() end, { desc = "Global search in workspace folder" })
map({ "n" }, "<leader>k", lsp.hover, { desc = "Show docs for item under cursor" })
map({ "n" }, "<leader>r", lsp.rename, { desc = "Rename symbol" })
map({ "n" }, "<leader>R", function() snacks.rename.rename_file() end, { desc = "Rename buffer" })
map({ "n" }, "<leader>?", function() picker.commands() end, { desc = "Open command palette" })
-- stylua: ignore end

--=========================================================
--= goto mode
--=========================================================

-- stylua: ignore start
map({ "n" }, "gg", "gg", { desc = "Go to line number <n> else start of file" })
map({ "n" }, "ge", "G", { desc = "Go to the end of the file" })
map({ "n" }, "gf", "gf", { desc = "Go to file under cursor" })
map({ "n" }, "gh", "0", { desc = "Go to the start of the line" })
map({ "n" }, "gl", "$", { desc = "Go to the end of the line" })
map({ "n" }, "gs", "^", { desc = "Go to the start of the line (first character)" })
map({ "n" }, "gt", "H", { desc = "Go to the top of the screen" })
map({ "n" }, "gc", "M", { desc = "Go to the middle of the screen" })
map({ "n" }, "gb", "L", { desc = "Go to the bottom of the screen" })
map({ "n" }, "gd", picker.lsp_definitions, { desc = "Go to definition (LSP)" })
map({ "n" }, "gD", picker.lsp_declarations, { desc = "Go to declaration (LSP)" })
map({ "n" }, "gy", picker.lsp_type_definitions, { desc = "Go to type definition (LSP)" })
map({ "n" }, "gr", picker.lsp_references, { desc = "Go to reference (LSP)", nowait = true })
map({ "n" }, "gI", picker.lsp_implementations, { desc = "Go to implementation (LSP)" })
map({ "n" }, "gK", lsp.signature_help, { desc = "Signature Help" })
map({ "n" }, "ga", "<C-^>", { desc = "Go to the last accessed/alternate file" })
map({ "n" }, "gn", "<cmd>BufferLineCycleNext<cr>", { desc = "Go to next buffer" })
map({ "n" }, "gp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Go to previous buffer" })
map({ "n" }, "g.", "g.", { desc = "Go to last modification in current file" })
map({ "n" }, "gj", "gj", { desc = "Move down textual (instead of visual) line" })
map({ "n" }, "gk", "gk", { desc = "Move up textual (instead of visual) line" })
-- stylua: ignore end

--=========================================================
--= neovide
--=========================================================

if vim.g.neovide == true then
  map({ "n" }, "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>")
  map({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  map({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  map({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end
