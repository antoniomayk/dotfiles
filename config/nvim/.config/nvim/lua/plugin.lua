local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = {
    missing = true,
    colorscheme = { "gruvbox" },
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "rounded",
    backdrop = 100,
    icons = {
      cmd = " ",
      config = "",
      debug = "● ",
      event = " ",
      favorite = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = " ",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
    throttle = 1000 / 30,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.keymap.set("n","<Leader>pi",function() require("lazy").install() end,             { desc = "Plugins Install" })
vim.keymap.set("n","<Leader>ps",function() require("lazy").home() end,                { desc = "Plugins Status" })
vim.keymap.set("n","<Leader>pS",function() require("lazy").sync() end,                { desc = "Plugins Sync" })
vim.keymap.set("n","<Leader>pu",function() require("lazy").check() end,               { desc = "Plugins Check Updates" })
vim.keymap.set("n","<Leader>pU",function() require("lazy").update() end,              { desc = "Plugins Update" })
