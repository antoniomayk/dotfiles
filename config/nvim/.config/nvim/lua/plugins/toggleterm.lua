return {
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      -- stylua: ignore start
      { "<leader>fT", mode = { "n" }, '<Cmd>execute v:count . "ToggleTerm" . " dir=" . getcwd() . "/" . expand("%:h")<CR>', desc = "Terminal (cwd)" },
      { "<leader>ft", mode = { "n" }, '<Cmd>execute v:count . "ToggleTerm"<CR>',                                    desc = "Terminal (Root Dir)" },
      { "<c-/>",      mode = { "n" }, '<Cmd>execute v:count . "ToggleTerm"<CR>',                                    desc = "Terminal (Root Dir)" },
      { "<c-/>",      mode = { "t" }, '<Cmd>execute v:count . "ToggleTerm"<CR>',                                    desc = "Terminal (Root Dir)" },
      -- stylua: ignore end
    },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 10,
      ---@param t Terminal
      on_create = function(t)
        vim.opt_local.foldcolumn = "0"
        vim.opt_local.signcolumn = "no"
        if t.hidden then
          local function toggle()
            t:toggle()
          end
          vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
          vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
        end
      end,
      shading_factor = 2,
      float_opts = { border = "rounded" },
    },
  },
}
