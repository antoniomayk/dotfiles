local bufline_bg = "#000000"
local bufline_bg_alt = "#000000"
local bufline_fg = "#928374"

local function highlight(group, hl_group_opt)
  local link = hl_group_opt.link
  if link ~= nil then
    local cmd = "hi! link " .. group .. " " .. link
    vim.api.nvim_command(cmd)
    return
  end
  vim.api.nvim_set_hl(0, group, hl_group_opt)
end

local function draw(hl_group_tbl)
  if hl_group_tbl == nil then
    return
  end
  for hl_group, value in pairs(hl_group_tbl) do
    highlight(hl_group, value)
  end
end

local function setup_bufferline_icon()
  local icon_ok, webDevicons = pcall(require, "nvim-web-devicons")
  if not icon_ok then
    return
  end
  local filename = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")
  local _, icon_name = webDevicons.get_icon(filename, ext, { default = true })
  local _, icon_color = webDevicons.get_icon_color(filename, ext, { default = true })
  if not icon_name then
    return
  end
  local iconSkeleton = {
    ["BufferLine" .. icon_name .. "Selected"] = {
      bg = bufline_bg,
      fg = icon_color,
    },
    ["BufferLine" .. icon_name] = {
      bg = bufline_bg,
      fg = icon_color,
    },
    ["BufferLine" .. icon_name .. "Inactive"] = {
      bg = bufline_bg,
      fg = icon_color,
    },
  }
  return iconSkeleton
end

return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = function(_)
      ---@class GruvboxPalette
      local palette = require("gruvbox").palette

      return {
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard",
        palette_overrides = {},
        -- stylua: ignore start
        overrides = {
          -------------------------------------------------
          -- highlight-group
          -------------------------------------------------
          Normal = { bg = "#000000" },
          NormalFloat = { bg = "#000000" },
          CursorLine = { bg = palette.dark0 },
          CursorLineNr = { bg = "#000000" },
          CursorLineFold = { bg = "#000000" },
          CursorLineSign = { bg = "#000000" },
          FoldColumn = { bg = "#000000" },
          Folded = { bg = "#000000" },
          FloatBorder = { bg = "#000000" },
          SignColumn = { bg = "#000000" },
          StatusLine = { bg = "#000000" },
          TabLine = { bg = "#000000" },
          TabLineFill = { bg = "#000000" },
          TabLineSel = { bg = "#000000" },
          WinBarNC = { bg = "#000000" },
          WinSeparator = { fg = palette.dark0, bg = "#000000" },
          Pmenu = { bg = "#000000" },
          PmenuSel = { fg = "#000000" },
          PmenuSbar = { bg = "#000000" },
          PmenuThumb = { bg = palette.bright_orange },
          -------------------------------------------------
          -- diagnostics
          -------------------------------------------------
          DiagnosticSignError = { fg = palette.bright_red },
          DiagnosticSignWarn = { fg = palette.bright_yellow },
          DiagnosticSignInfo = { fg = palette.bright_blue },
          DiagnosticSignHint = { fg = palette.bright_aqua },
          DiagnosticSignOk = { fg = palette.bright_green },
          DiagnosticFloatingOk = { fg = palette.bright_green },
          -------------------------------------------------
          -- neotree
          -------------------------------------------------
          NeoTreeIndentMarker = { fg = palette.bright_blue },
          NeoTreeWinSeparator = { fg = palette.dark0, bg = "#000000" },
          NeoTreeMessage = { link = "NeoTreeDotfile" },
          NeoTreeNormal = { bg = "#000000" },
          NeoTreeNormalNC = { link = "NeoTreeNormal" },
          NeoTreeDotfile = { fg = palette.bright_blue },
          NeoTreeDotfiles = { link = "NeoTreeDotfile" },
          NeoTreeTabActive = { fg = "#000000", bg = palette.bright_blue, bold = true },
          NeoTreeTabInactive = { fg = palette.bright_blue, bg = "#000000" },
          NeoTreeTabSeparatorActive = { fg = palette.bright_blue, bg = palette.bright_blue },
          NeoTreeTabSeparatorInactive = { link = "NeoTreeWinSeparator" },
          NeoTreeTitleBar = { link = "NeoTreeTabActive" },
          NeoTreeFloatNormal = { bg = "#000000" },
          NeoTreeFloatBorder = { fg = palette.bright_blue, bg = "#000000" },
          -------------------------------------------------
          -- heirline
          -------------------------------------------------
          HeirlineInactive = { bg = palette.gray },
          HeirlineNormal = { bg = palette.bright_blue },
          HeirlineInsert = { bg = palette.bright_green },
          HeirlineVisual = { bg = palette.bright_purple },
          HeirlineReplace = { bg = palette.bright_red },
          HeirlineCommand = { bg = palette.bright_yellow },
          HeirlineTerminal = { link = "HeirlineInsert" },
          -------------------------------------------------
          -- bufferline
          -------------------------------------------------
          BufferLineBackground                 = { bg = bufline_bg, fg = bufline_fg },
          BufferLineBuffer                     = { bg = bufline_bg, fg = bufline_fg },
          BufferLineBufferSelected             = { bg = bufline_bg, fg = palette.bright_blue },
          BufferLineBufferVisible              = { bg = bufline_bg, fg = bufline_fg },
          BufferLineCloseButton                = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineCloseButtonSelected        = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineCloseButtonVisible         = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineDevIconDefault             = { bg = bufline_bg, },
          BufferLineDevIconDefaultInvactive    = { bg = bufline_bg,  },
          BufferLineDevIconDefaultSelected     = { bg = bufline_bg,  },
          BufferLineDiagnostic                 = { bg = bufline_bg, fg = bufline_fg },
          BufferLineDiagnosticSelected         = { bg = bufline_bg, fg = bufline_fg },
          BufferLineDiagnosticVisible          = { bg = bufline_bg, fg = bufline_fg },
          BufferLineDuplicate                  = { bg = bufline_bg, fg = bufline_fg },
          BufferLineDuplicateSelected          = { bg = bufline_bg, fg = bufline_fg },
          BufferLineDuplicateVisible           = { bg = bufline_bg, fg = bufline_fg },
          BufferLineError                      = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineErrorDiagnostic            = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineErrorDiagnosticSelected    = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineErrorDiagnosticVisible     = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineErrorSelected              = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineErrorVisible               = { bg = bufline_bg, fg = palette.bright_red },
          BufferLineFill                       = { bg = bufline_bg_alt,fg = bufline_fg },
          BufferLineGroupLabel                 = { bg = bufline_bg, fg = bufline_fg },
          BufferLineGroupSeparator             = { bg = bufline_bg, fg = bufline_fg },
          BufferLineHint                       = { bg = bufline_bg, fg = palette.bright_aqua },
          BufferLineHintDiagnostic             = { bg = bufline_bg, fg = palette.bright_aqua },
          BufferLineHintDiagnosticSelected     = { bg = bufline_bg, fg = palette.bright_aqua },
          BufferLineHintDiagnosticVisible      = { bg = bufline_bg, fg = palette.bright_aqua },
          BufferLineHintSelected               = { bg = bufline_bg, fg = palette.bright_aqua },
          BufferLineHintVisible                = { bg = bufline_bg, fg = palette.bright_aqua },
          BufferLineIndicatorSelected          = { bg = bufline_bg, fg = bufline_fg },
          BufferLineIndicatorVisible           = { bg = bufline_bg, fg = bufline_fg },
          BufferLineInfo                       = { bg = bufline_bg, fg = palette.bright_blue },
          BufferLineInfoDiagnostic             = { bg = bufline_bg, fg = palette.bright_blue },
          BufferLineInfoDiagnosticSelected     = { bg = bufline_bg, fg = palette.bright_blue },
          BufferLineInfoDiagnosticVisible      = { bg = bufline_bg, fg = palette.bright_blue },
          BufferLineInfoSelected               = { bg = bufline_bg, fg = palette.bright_blue },
          BufferLineInfoVisible                = { bg = bufline_bg, fg = palette.bright_blue },
          BufferLineModified                   = { bg = bufline_bg, fg = bufline_fg },
          BufferLineModifiedSelected           = { bg = bufline_bg, fg = bufline_fg },
          BufferLineModifiedVisible            = { bg = bufline_bg, fg = bufline_fg },
          BufferLineNumbers                    = { bg = bufline_bg, fg = bufline_fg },
          BufferLineNumbersSelected            = { bg = bufline_bg, fg = bufline_fg },
          BufferLineNumbersVisible             = { bg = bufline_bg, fg = bufline_fg },
          BufferLineOffsetSeparator            = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLinePick                       = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLinePickSelected               = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLinePickVisible                = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineSeparator                  = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineSeparatorSelected          = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineSeparatorVisible           = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineTab                        = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineTabClose                   = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineTabSelected                = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineTabSeparator               = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineTabSeparatorSelected       = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineTruncMarker                = { bg = bufline_bg, fg = bufline_bg_alt },
          BufferLineWarning                    = { bg = bufline_bg, fg = palette.bright_yellow },
          BufferLineWarningDiagnostic          = { bg = bufline_bg, fg = palette.bright_yellow },
          BufferLineWarningDiagnosticSelected  = { bg = bufline_bg, fg = palette.bright_yellow },
          BufferLineWarningDiagnosticVisible   = { bg = bufline_bg, fg = palette.bright_yellow },
          BufferLineWarningSelected            = { bg = bufline_bg, fg = palette.bright_yellow },
          BufferLineWarningVisible             = { bg = bufline_bg, fg = palette.bright_yellow },
        },
        -- stylua: ignore end
        dim_inactive = false,
        transparent_mode = true,
      }
    end,
    init = function()
      vim.cmd("colorscheme gruvbox")

      vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWinEnter", "BufRead" }, {
        pattern = "*",
        callback = function()
          if vim.g.colors_name ~= "gruvbox" then
            return true
          end
          local bufferline_icon_group = setup_bufferline_icon()
          draw(bufferline_icon_group)
        end,
      })
    end,
  },
}
