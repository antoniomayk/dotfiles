-- Insert mode convenience
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "jj to Escape" })
vim.keymap.set("i", "kk", "<Esc>", { noremap = true, silent = true, desc = "kk to Escape" })

-- Keep cursor position on line create
vim.keymap.set("n", "o", "o<Esc>", { noremap = true, silent = true, desc = "Create line below" })
vim.keymap.set("n", "O", "O<Esc>", { noremap = true, silent = true, desc = "Create line above" })

-- Yank to end of line
vim.keymap.set("n", "Y", "y$", { noremap = true, silent = true, desc = "Yank to end of line" })

-- Window resizing (noremap applies to n, v, o)
local resize_opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "v", "o" }, "<c-w>+", ":horizontal resize +5<CR>", resize_opts)
vim.keymap.set({ "n", "v", "o" }, "<c-w>-", ":horizontal resize -5<CR>", resize_opts)
vim.keymap.set({ "n", "v", "o" }, "<c-w>>", ":vertical resize +5<CR>", resize_opts)
vim.keymap.set({ "n", "v", "o" }, "<c-w><", ":vertical resize -5<CR>", resize_opts)

-- Clear search highlight
vim.keymap.set("n", "<esc>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })

-- Buffer Management
vim.keymap.set('n', '<leader>bn', ':enew<CR>', { desc = 'New Buffer' })
vim.keymap.set('n', '<leader>bs', ':w<CR>', { desc = 'Save Buffer' })
vim.keymap.set('n', '<leader>ba', ':wa<CR>', { desc = 'Save All Buffers' })
vim.keymap.set('n', '<leader>bt', ':tabnew<CR>', { desc = 'New Tab with Empty Buffer' })
vim.keymap.set('n', '<leader>bT', ':tabclose<CR>', { desc = 'Close Current Tab' })
vim.keymap.set('n', '<leader>bh', ':hide<CR>', { desc = 'Hide Buffer' })
