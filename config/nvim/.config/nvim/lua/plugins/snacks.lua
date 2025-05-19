return {
  {
    "folke/snacks.nvim",
    keys = {
      -- stylua: ignore start
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
      { "<leader>br", function() Snacks.bufdelete.delete({ force = true, filter = function (bufnr) return vim.api.nvim_get_current_buf() < bufnr end}) end, desc = "Delete Buffers to the Right" },
      { "<leader>bl", function() Snacks.bufdelete.delete({ force = true, filter = function (bufnr) return vim.api.nvim_get_current_buf() > bufnr end}) end, desc = "Delete Buffers to the Left" },
      { "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      -- stylua: ignore end
    },
    ---@type snacks.Config
    opts = {
      input = { enabled = true },
      rename = { enabled = true },
      bufdelete = { enabled = true },
      statuscolumn = { enabled = true },
      indent = {
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 20, -- ms per step
            total = 200, -- maximum duration
          },
        },
        chunk = {
          enabled = true,
          only_current = false,
          priority = 200,
          hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = "─",
          },
        },
      },
      quickfile = { enabled = true },
      picker = {
        layout = {
          layout = {
            backdrop = 100,
          },
        },
      },
    },
  },
}
