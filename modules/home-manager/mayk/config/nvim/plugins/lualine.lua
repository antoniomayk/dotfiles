-- vim

local fn = vim.fn
local api = vim.api
local lsp = vim.lsp

-- gruvbox

local palette = require("gruvbox").palette

-- lualine

local lualine = require("lualine")

local colors = {
  bg = "#000000",
  fg = palette.white,
  yellow = palette.bright_yellow,
  cyan = palette.bright_aqua,
  darkblue = palette.blue,
  green = palette.bright_green,
  orange = palette.bright_orange,
  violet = palette.bright_purple,
  magenta = palette.neutral_purple,
  blue = palette.bright_blue,
  red = palette.bright_red,
}

local conditions = {
  buffer_not_empty = function()
    return fn.empty(fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = fn.expand("%:p:h")
    local gitdir = fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  extensions = {
    "aerial",
    "chadtree",
    "ctrlspace",
    "fern",
    "fugitive",
    "fzf",
    "lazy",
    "man",
    "mason",
    "mundo",
    "nerdtree",
    "nvim-dap-ui",
    "nvim-tree",
    "oil",
    "overseer",
    "quickfix",
    "symbols-outline",
    "toggleterm",
    "trouble",
  },
  options = {
    disabled_buftypes = { "neo-tree" },
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
    refresh = {
      statusline = 1000,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

--=========================================================
--= setup
--=========================================================

ins_left({
  function()
    return " "
  end,
  color = { fg = colors.blue },
  padding = { left = 0, right = 0 },
})

ins_left({
  function()
    return ""
  end,
  color = function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[fn.mode()] }
  end,
  padding = { right = 1 },
})

ins_left({
  "filesize",
  cond = conditions.buffer_not_empty,
})

ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
})

ins_left({
  function()
    return "%="
  end,
})

ins_left({
  function()
    local buf_ft = api.nvim_get_option_value("filetype", { buf = 0 })
    local lsps = "[ "
    for ft, linters in pairs(require("lint").linters_by_ft) do
      if ft == buf_ft then
        lsps = lsps .. table.concat(linters, " ") .. " "
      end
    end
    return lsps .. "]"
  end,
  icon = "  LINT:",
  color = { fg = colors.fg, gui = "bold" },
})

ins_left({
  function()
    local buf_ft = api.nvim_get_option_value("filetype", { buf = 0 })
    local clients = lsp.get_clients()
    local lsps = "[ "
    for _, client in ipairs(clients) do
      ---@diagnostic disable-next-line: undefined-field
      local filetypes = client.config.filetypes
      if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
        lsps = lsps .. client.name .. " "
      end
    end
    return lsps .. "]"
  end,
  icon = "  LSP:",
  color = { fg = colors.fg, gui = "bold" },
})

ins_right({
  "o:encoding",
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
})

ins_right({
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    return ""
  end,
  color = { fg = colors.blue },
  padding = { left = 0 },
})

lualine.setup(config)
