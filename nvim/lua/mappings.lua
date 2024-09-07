local wk = require("which-key")

-- stylua: ignore
wk.add({
  { "<c-x>",    "<c-\\><c-n>",  mode = { "t" }, hidden = true,  desc = "Escape terminal mode" },
  { "<esc>",    "<cmd>noh<cr>", mode = { "n" }, hidden = true,  desc = "General clear highlights" },
  { "<c-b>",    "<esc>^i",      mode = { "i" }, hidden = true,  desc = "Move beginning of line" },
  { "<c-e>",    "<end>",        mode = { "i" }, hidden = true,  desc = "Move end of line" },
  { "<c-h>",    "<left>",       mode = { "i" }, hidden = true,  desc = "Move left" },
  { "<c-l>",    "<right>",      mode = { "i" }, hidden = true,  desc = "Move right" },
  { "<c-j>",    "<down>",       mode = { "i" }, hidden = true,  desc = "Move down" },
  { "<c-k>",    "<up>",         mode = { "i" }, hidden = true,  desc = "Move up" },
  { "<c-h>",    "<c-w>h",       mode = { "n" }, hidden = true,  desc = "Switch window left" },
  { "<c-l>",    "<c-w>l",       mode = { "n" }, hidden = true,  desc = "Switch window right" },
  { "<c-j>",    "<c-w>j",       mode = { "n" }, hidden = true,  desc = "Switch window down" },
  { "<c-k>",    "<c-w>k",       mode = { "n" }, hidden = true,  desc = "Switch window up" },
})

-- stylua: ignore
wk.add({
  { "<leader>b",                                        group = "Buffers" },
  { "<leader>bs",   "<cmd>w<cr>",           mode = "n", desc  = "Save" },
  { "<leader>ba",   "<cmd>wa<cr>",          mode = "n", desc  = "Save all" },
  { "<leader>bc",   "<cmd>%y+<cr>",         mode = "n", desc  = "Copy whole" },
  { "<leader>bl",   "<cmd>set nu!<cr>",     mode = "n", desc  = "Toggle line number" },
  { "<leader>br",   "<cmd>set rnu!<cr>",    mode = "n", desc  = "Toggle relative number" },
  { "<leader>bn",   "<cmd>enew<cr>",        mode = "n", desc  = "New" },
  { "<leader>bd",   "<cmd>bd<cr>",          mode = "n", desc  = "Delete" },
  { "<leader>bD",   "<cmd>bd!<cr>",         mode = "n", desc  = "Force delete" },
})

-- stylua: ignore
wk.add({
  { "<tab>",        "<cmd>BufferLineCycleNext<cr>", mode = "n", hidden = true,  desc = "Buffer goto next" },
  { "<s-tab>",      "<cmd>BufferLineCyclePrev<cr>", mode = "n", hidden = true,  desc = "Buffer goto prev" },
  { "<leader>x",    "<cmd>bd<cr><bar><cmd>bp<cr>",  mode = "n", hidden = true,  desc = "Buffer close" } ,
})

-- stylua: ignore
wk.add({
  { "<leader>t",                                                group = "Tabs" },
  { "<leader>tn",   "<cmd>BufferLineCycleNext<cr>", mode = "n", desc  = "Next" },
  { "<leader>tp",   "<cmd>BufferLineCyclePrev<cr>", mode = "n", desc  = "Previous" },
  { "<leader>tc",   "<cmd>bd<cr><bar><cmd>bp<cr>",  mode = "n", desc  = "Close" },
  { "<leader>tc",   "<cmd>BufferLineCloseOthers<cr>",  mode = "n", desc  = "Close others" },
})

-- stylua: ignore
wk.add({
  { "<leader>c",                        group = "Comments" },
  { "<leader>ct",   "gcc",  mode = "n", desc  = "Toggle" },
  { "<leader>ct",   "gc",   mode = "v", desc  = "Toggle" },
})

-- stylua: ignore
wk.add({
  { "<leader>n",                                                group = "NvimTree" },
  { "<leader>nt",   "<cmd>NvimTreeToggle<cr>",      mode = "n", desc  = "Toggle" },
  { "<leader>nf",   "<cmd>NvimTreeFocus<cr>",       mode = "n", desc  = "Focus" },
  { "<leader>nc",   "<cmd>NvimTreeClose<cr>",       mode = "n", desc  = "Close" },
  { "<leader>n+",   "<cmd>NvimTreeResize +10<cr>",  mode = "n", desc  = "Increase" },
  { "<leader>n-",   "<cmd>NvimTreeResize -10<cr>",  mode = "n", desc  = "Decrease" },
})

-- stylua: ignore
wk.add({
  { "<leader>t",                                                                                        group = "Toggle term" },
  { "<leader>th",   "<cmd>ToggleTerm direction=horizontal<cr>", mode = { "n" },         hidden = false, desc  = "Toggle" },
  { "<leader>tv",   "<cmd>ToggleTerm direction=vertical<cr>",   mode = { "n" },         hidden = false, desc  = "Focus" },
  { "<leader>tf",   "<cmd>ToggleTerm direction=float<cr>",      mode = { "n" },         hidden = false, desc  = "Focus" },
  { "<a-h>",        "<cmd>ToggleTermToggleAll<cr>",             mode = { "n", "t" },    hidden = true,  desc  = "Toggle all" },
})

-- stylua: ignore
wk.add({
  { "<leader>f",                                                                                                group = "Finder" },
  { "<leader>fg",   "<cmd>Telescope live_grep<cr>",                                           mode = { "n" },   desc  = "Live grep" },
  { "<leader>fb",   "<cmd>Telescope buffers<cr>",                                             mode = { "n" },   desc  = "Find buffers" },
  { "<leader>ft",   "<cmd>Telescope help_tags<cr>",                                           mode = { "n" },   desc  = "Help page" },
  { "<leader>fm",   "<cmd>Telescope marks<cr>",                                               mode = { "n" },   desc  = "Find marks" },
  { "<leader>fo",   "<cmd>Telescope oldfiles<cr>",                                            mode = { "n" },   desc  = "Find oldfiles" },
  { "<leader>fc",   "<cmd>Telescope current_buffer_fuzzy_find<cr>",                           mode = { "n" },   desc  = "Find in current buffer" },
  { "<leader>fG",                                                                                               group = "Git" },
  { "<leader>fGc",  "<cmd>Telescope git_commits<cr>",                                         mode = { "n" },   desc  = "Git commits" },
  { "<leader>fGs",  "<cmd>Telescope git_status<cr>",                                          mode = { "n" },   desc  = "Git status" },
  { "<leader>ft",   "<cmd>Telescope terms<cr>",                                               mode = { "n" },   desc  = "Pick hidden term" },
  { "<leader>fh",   "<cmd>Telescope themes<cr>",                                              mode = { "n" },   desc  = "Nvchad themes" },
  { "<leader>ff",   "<cmd>Telescope find_files<cr>",                                          mode = { "n" },   desc  = "Find files" },
  { "<leader>fa",   "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",   mode = { "n" },   desc  = "Find all files" },
})

-- stylua: ignore
wk.add({
  { "<leader>w",                                                                                        group = "WhichKey" },
  { "<leader>wa",   "<cmd>WhichKey<cr>",                                                mode = { "n" }, desc  = "All keymaps" },
  { "<leader>wq",   "<cmd>lua vim.cmd('WhichKey ' .. vim.fn.input('WhichKey: '))<cr>",  mode = { "n" }, desc  = "Query lookup" },
})

-- stylua: ignore
wk.add({
  { "<leader>l",                                                                                    group = "LSP" },
  { "<leader>lf",   "<cmd>lua require('conform').format({ lsp_fallback = true })<cr>",  mode = "n", desc  = "Format" },
  { "<leader>lr",   function() return ":IncRename " .. vim.fn.expand("<cword>") end,    mode = "n", desc  = "Rename", expr = true },
})

-- stylua: ignore
wk.add({
  { "<leader>r",                                                                group = "Rustacean" },
  { "<leader>rx",    "<cmd>RustLsp expandMacro<cr>",                mode = "n", desc  = "Format" },
  { "<leader>ra",    "<cmd>RustLsp hover actions<cr>",              mode = "n", desc  = "Actions" },
  { "<leader>rj",    "<cmd>RustLsp joinLines<cr>",                  mode = "n", desc  = "Join Lines" },
  -- Errors
  { "<leader>re",                                                               group = "Errors" },
  { "<leader>rec",   "<cmd>RustLsp explainError current<cr>",       mode = "n", desc  = "Current" },
  { "<leader>ren",   "<cmd>RustLsp explainError cycle<cr>",         mode = "n", desc  = "Next" },
  -- Diagnostics
  { "<leader>rd",                                                               group = "Diagnostics" },
  { "<leader>rdc",   "<cmd>RustLsp renderDiagnostic current<cr>",   mode = "n", desc  = "Current" },
  { "<leader>rdn",   "<cmd>RustLsp renderDiagnostic cycle<cr>",     mode = "n", desc  = "Next" },
  -- Move Items
  { "<leader>rm",                                                               group = "Move Items" },
  { "<leader>rmu",   "<cmd>RustLsp moveItem up<cr>",                mode = "n", desc  = "Up" },
  { "<leader>rmd",   "<cmd>RustLsp moveItem down<cr>",              mode = "n", desc  = "Down" },
  -- Open
  { "<leader>ro",                                                               group = "Open" },
  { "<leader>rod",   "<cmd>RustLsp openDocs<cr>",                   mode = "n", desc  = "Docs" },
  { "<leader>roc",   "<cmd>RustLsp openCargo<cr>",                  mode = "n", desc  = "Cargo.toml" },
  -- Fly Check
  { "<leader>rf",                                                               group = "Fly Check" },
  { "<leader>rfr",   "<cmd>RustLsp flyCheck run<cr>",               mode = "n", desc  = "Run" },
  { "<leader>rfc",   "<cmd>RustLsp flyCheck clear<cr>",             mode = "n", desc  = "Clear" },
  { "<leader>rfC",   "<cmd>RustLsp flyCheck cancel<cr>",            mode = "n", desc  = "Cancel" },
  -- Unpretty
  { "<leader>ru",                                                               group = "Unpretty" },
  { "<leader>rur",   "<cmd>Rustc unpretty hir<cr>",                 mode = "n", desc  = "HIR" },
  { "<leader>ruc",   "<cmd>Rustc unpretty mir<cr>",                 mode = "n", desc  = "MIR" },
  -- Runnables
  { "<leader>rr",                                                               group = "Runables" },
  { "<leader>rrr",   "<cmd>RustLsp run<cr>",                        mode = "n", desc  = "Run target" },
  { "<leader>rrl",   "<cmd>RustLsp runnables<cr>",                  mode = "n", desc  = "List availables target" },
  { "<leader>rrp",   "<cmd>RustLsp[!] runnables<cr>",               mode = "n", desc  = "Run previous runnables" },
  { "<leader>rra",   "<cmd>RustLsp runnables ",                     mode = "n", desc  = "Custom arguments" },
  -- Debuggables
  { "<leader>rD",                                                               group = "Debuggables" },
  { "<leader>rDd",   "<cmd>RustLsp debug<cr>",          mode = "n", desc  = "Debug" },
  { "<leader>rDl",   "<cmd>RustLsp debuggables<cr>",    mode = "n", desc  = "List debuggables" },
  { "<leader>rDp",   "<cmd>RustLsp[!] debuggables<cr>", mode = "n", desc  = "List previous debuggables" },
  { "<leader>rDa",   "<cmd>RustLsp debuggables ",       mode = "n", desc  = "Debuggables (Override args)" },
  -- Testables
  { "<leader>rt",                                                               group = "Testables" },
  { "<leader>rtr",   "<cmd>RustLsp testables<cr>",                  mode = "n", desc  = "Run tests" },
  { "<leader>rtp",   "<cmd>RustLsp[!] testables<cr>",               mode = "n", desc  = "Run the previous testables" },
  { "<leader>rtc",   "<cmd>RustLsp testables ",                     mode = "n", desc  = "Override args" },
})

-- stylua: ignore
wk.add({
  { "<leader>s",                                                                        group = "Session Manager" },
  { "<leader>sa",   "<cmd>SessionManager available_commands<cr>",           mode = "n", desc  = "Available commands" },
  { "<leader>ss",   "<cmd>SessionManager save_current_session<cr>",         mode = "n", desc  = "Save session" },
  { "<leader>sl",   "<cmd>SessionManager load_session<cr>",                 mode = "n", desc  = "Load session" },
  { "<leader>sL",   "<cmd>SessionManager load_last_session<cr>",            mode = "n", desc  = "Load last session" },
  { "<leader>sd",   "<cmd>SessionManager delete_current_dir_session<cr>",   mode = "n", desc  = "Delete current dir session" },
  { "<leader>sD",   "<cmd>SessionManager delete_session<cr>",               mode = "n", desc  = "Delete session" },
})

-- stylua: ignore
wk.add({
  { "<leader>T",                                                                            group = "Trouble" },
  { "<leader>Tx", "<cmd>Trouble diagnostics toggle<cr>",                        mode = "n", desc  = "Diagnostics", },
  { "<leader>TX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           mode = "n", desc  = "Buffer Diagnostics", },
  { "<leader>Ts", "<cmd>Trouble symbols toggle focus=false<cr>",                mode = "n", desc  = "Symbols", },
  { "<leader>Tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", mode = "n", desc  = "LSP Definitions / references / ...", },
  { "<leader>TL", "<cmd>Trouble loclist toggle<cr>",                            mode = "n", desc  = "Location List", },
  { "<leader>TQ", "<cmd>Trouble qflist toggle<cr>",                             mode = "n", desc  = "Quickfix List", },
})

-- stylua: ignore
wk.add({
  { "<leader>m",                                                    group = "Markdown Render" },
  { "<leader>me", "<cmd>RenderMarkdown enable<cr>",     mode = "n", desc  = "Enable", },
  { "<leader>md", "<cmd>RenderMarkdown disable<cr>",    mode = "n", desc  = "Disable", },
  { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>",     mode = "n", desc  = "Toggle", },
})

-- stylua: ignore
wk.add({
  -- DAP
  { "<leader>d",                                                                                                                                                  group = "DAP" },
  { "<leader>dc", function() require('dap').continue() end,                                                                                 mode = { "n" },       desc  = "Continue", },
  { "<leader>di", function() require('dap').step_into() end,                                                                                mode = { "n" },       desc  = "Step into", },
  { "<leader>do", function() require('dap').step_out() end,                                                                                 mode = { "n" },       desc  = "Step out", },
  { "<leader>dr", function() require('dap').restart() end,                                                                                  mode = { "n" },       desc  = "Session restart", },
  { "<leader>dD", function() require('dap').disconnect() end,                                                                               mode = { "n" },       desc  = "Disconnect", },
  { "<leader>db", function() require('dap').toggle_breakpoint() end,                                                                        mode = { "n" },       desc  = "Toggle breakpoint", },
  { "<leader>dB", function() require('dap').set_breakpoint() end,                                                                           mode = { "n" },       desc  = "Set breakpoint", },
  { "<leader>dr", function() require('dap').repl.open() end,                                                                                mode = { "n" },       desc  = "REPL", },
  { "<leader>dl", function() require('dap').run_last() end,                                                                                 mode = { "n" },       desc  = "Run last", },
  { "<leader>dh", function() require('dap.ui.widgets').hover(nil, { border = 'rounded' }) end,                                              mode = { "n", "v" },  desc  = "Hover", },
  { "<leader>dp", function() require('dap.ui.widgets').preview(nil) end,                                                                    mode = { "n", "v" },  desc  = "Preview", },
  { "<leader>dl", function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames, { border = 'rounded' }) end,  mode = { "n" },       desc  = "Frames", },
  { "<leader>dl", function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes, { border = 'rounded' }) end,  mode = { "n" },       desc  = "Scopes", },
  -- DAP UI
  { "<leader>du",                                                                                                                                                 group = "UI" },
  { "<leader>duo", function() require('dapui').open() end,                                                                                  mode = { "n" },       desc  = "Open", },
  { "<leader>dut", function() require('dapui').toggle() end,                                                                                mode = { "n" },       desc  = "Toggle", },
  { "<leader>duc", function() require('dapui').close() end,                                                                                 mode = { "n" },       desc  = "Close", },
  { "<leader>due", function() require("dapui").eval(nil, { enter = true }) end,                                                             mode = { "n", "v" },  desc  = "Evaluate", },
  { "<leader>duE", function() require("dapui").eval(vim.fn.input('Eval'), { enter = true }) end,                                            mode = { "n"},        desc  = "Evaluate expression", },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-float",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
  end,
})

-- stylua: ignore
wk.add({
  { "<leader>N",                                                      group = "Neotest" },
  { "<leader>Ns", '<cmd>Neotest summary toggle<cr>',  mode = { "n" }, desc  = "Summary", },
  { "<leader>Nr", '<cmd>Neotest run<cr>',             mode = { "n" }, desc  = "Run", },
  { "<leader>Nq", '<cmd>Neotest stop<cr>',            mode = { "n" }, desc  = "Stop", },
  { "<leader>No", '<cmd>Neotest output<cr>',          mode = { "n" }, desc  = "Output", },
  { "<leader>Np", '<cmd>Neotest output-panel<cr>',    mode = { "n" }, desc  = "Output panel", },
  { "<leader>Nj",                                                     group = "Jump" },
  { "<leader>Njn", '<cmd>Neotest jump next<cr>',      mode = { "n" }, desc  = "Next", },
  { "<leader>Njp", '<cmd>Neotest jump prev<cr>',      mode = { "n" }, desc  = "Previous", },
})

