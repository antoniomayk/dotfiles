-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "markemmons/neotest-deno" },
      { "stevanmilic/neotest-scala" },
      { "rcasia/neotest-java" },
    },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-deno" {})
      table.insert(opts.adapters, require "neotest-java" {})
      table.insert(
        opts.adapters,
        require "neotest-scala" {
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          args = { "--no-color" },
          -- Runner to use. Will use bloop by default.
          -- Can be a function to return dynamic value.
          -- For backwards compatibility, it also tries to read the vim-test scala config.
          -- Possibly values bloop|sbt.
          runner = "bloop",
          -- Test framework to use. Will use utest by default.
          -- Can be a function to return dynamic value.
          -- Possibly values utest|munit|scalatest.
          framework = "munit",
        }
      )
      opts.icons = {
        running_animated = {
          "⠋",
          "⠙",
          "⠚",
          "⠒",
          "⠂",
          "⠂",
          "⠒",
          "⠲",
          "⠴",
          "⠦",
          "⠖",
          "⠒",
          "⠐",
          "⠐",
          "⠒",
          "⠓",
          "⠋",
        },
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
      }
      return opts
    end,
  },
}
