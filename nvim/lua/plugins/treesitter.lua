return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        modules = {},
        auto_install = true,
        ignore_install = {},
        ensure_installed = { "java", "c", "lua", "vim", "vimdoc", "javascript", "html", "rust" },
        sync_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
