--
-- FUNCTIONS
--

local function quit_nvim()
    vim.api.nvim_input("<cmd>qa<cr>")
end

local function  open_nvim_config()
  local config = "~/.config/nvim/"

  local telescope = require("telescope.builtin")
  local fn = vim.fn

  fn.chdir(config)
  telescope.find_files()
end

--
-- PLUGIN
--

return {
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    opts = function()
      local logo = [[
  
   ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
   ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
  ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
  ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
  ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
  ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
  ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
     ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
           ░    ░  ░    ░ ░        ░   ░         ░   
                                  ░                  
    ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            --stylua: ignore start
            { action = "Telescope find_files follow=true no_ignore=true hidden=true",   desc = " Find File",        icon = " ",    key = "f" },
            { action = "ene | startinsert",                                             desc = " New File",         icon = " ",    key = "n" },
            { action = "Telescope oldfiles",                                            desc = " Recent Files",     icon = " ",    key = "r" },
            { action = "Telescope live_grep",                                           desc = " Find Text",        icon = " ",    key = "g" },
            { action = open_nvim_config,                                                desc = " Config",           icon = " ",    key = "c" },
            { action = "SessionManager load_session",                                   desc = " Restore Session",  icon = " ",    key = "s" },
            { action = quit_nvim,                                                       desc = " Quit",             icon = " ",    key = "q" },
            --stylua: ignore end
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },
  {
    "Shatur/neovim-session-manager",
    opts = {},
    config = function()
      local Path = require("plenary.path")
      local config = require("session_manager.config")
      require("session_manager").setup({
        sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
        autoload_mode = config.AutoloadMode.Disabled,
        autosave_last_session = true,
        autosave_ignore_not_normal = true,
        autosave_ignore_dirs = {},
        autosave_ignore_filetypes = {
          "gitcommit",
          "gitrebase",
        },
        autosave_ignore_buftypes = {},
        autosave_only_in_session = false,
        max_path_length = 80,
      })
    end,
  },
}
