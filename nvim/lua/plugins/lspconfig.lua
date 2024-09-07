return {
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-calc" },
  {
    "petertriho/cmp-git",
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {},
    init = function()
      table.insert(require("cmp").get_config().sources, { name = "git" })
    end,
  },
  { "L3MON4D3/LuaSnip" },
}
