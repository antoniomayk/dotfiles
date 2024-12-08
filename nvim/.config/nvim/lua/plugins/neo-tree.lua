return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    source_selector = {
      winbar = false,
    },
    popup_border_style = "rounded",
    window = {
      position = "float",
    },
    filesystem = {
      window = {
        mappings = {
          ["/"] = "noop",
          ["'"] = "telescope_find",
          [";"] = "telescope_grep",
        },
      },
      filtered_items = {
        visible = false,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
        },
        never_show = {},
      },
      group_empty_dirs = false,
    },
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        if node.type == "file" then node = state.tree:get_node(node:get_parent_id()) end
        local path = node:get_id()
        require("telescope.builtin").find_files(require("utils").getTelescopeOpts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        if node.type == "file" then node = state.tree:get_node(node:get_parent_id()) end
        local path = node:get_id()
        require("telescope.builtin").live_grep(require("utils").getTelescopeOpts(state, path))
      end,
    },
  },
}
