return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "lazy.nvim",
        "luvit-meta/library",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        "LazyVim",
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
      },
      -- enabled = function(root_dir)
      --   return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      -- end,
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
