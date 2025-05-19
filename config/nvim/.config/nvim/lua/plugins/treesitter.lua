return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      ignore_install = {},
      modules = {},
      ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown", "markdown_inline" },
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = false },
    },
  },
}
