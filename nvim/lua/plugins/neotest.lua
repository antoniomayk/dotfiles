return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rouge8/neotest-rust",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup({
        icons = {
          running_animated = { "⠋", "⠙", "⠚", "⠒", "⠂", "⠂", "⠒", "⠲", "⠴", "⠦", "⠖", "⠒", "⠐", "⠐", "⠒", "⠓", "⠋" },
          passed = "",
          running = "",
          failed = "",
          skipped = "",
          unknown = "",
          watching = "󰈈",
          notify = "",
          non_collapsible = "─",
          collapsed = "─",
          expanded = "╮",
          child_prefix = "├",
          final_child_prefix = "╰",
          child_indent = "│",
          final_child_indent = " ",
        },
        adapters = {
          require("neotest-rust"),
        },
      })
    end,
  },
}
