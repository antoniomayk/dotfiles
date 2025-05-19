return {
  {
    "2KAbhishek/pickme.nvim",
    cmd = "PickMe",
    event = "VeryLazy",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      picker_provider = "snacks", -- Options: 'snacks' (default), 'telescope', 'fzf_lua'
      detect_provider = true,
      add_default_keybindings = true,
      command_aliases = {},
    },
  },
}
