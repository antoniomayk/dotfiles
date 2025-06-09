-- vim

local api = vim.api
local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local tbl_deep_extend = vim.tbl_deep_extend

-- gruvbox

local gruvbox = require("gruvbox")
local p = tbl_deep_extend("force", gruvbox.palette, { off = "#000000" })

--=========================================================
--= setup
--=========================================================

gruvbox.setup({
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
  overrides = {
    -------------------------------------------------
    -- highlight-group
    -------------------------------------------------
    Normal = { bg = p.off },
    NormalFloat = { bg = p.off },
    CursorLine = { bg = p.dark0 },
    CursorLineNr = { bg = p.off },
    CursorLineFold = { bg = p.off },
    CursorLineSign = { bg = p.off },
    FoldColumn = { bg = p.off },
    Folded = { bg = p.off },
    FloatBorder = { bg = p.off },
    SignColumn = { bg = p.off },
    StatusLine = { bg = p.off },
    TabLine = { bg = p.off },
    TabLineFill = { bg = p.off },
    TabLineSel = { bg = p.off },
    WinBarNC = { bg = p.off },
    WinSeparator = { fg = p.dark0, bg = p.off },
    Pmenu = { bg = p.off },
    PmenuSel = { fg = p.off },
    PmenuSbar = { bg = p.off },
    PmenuThumb = { bg = p.bright_orange },
    -------------------------------------------------
    -- diagnostics
    -------------------------------------------------
    DiagnosticSignError = { fg = p.bright_red },
    DiagnosticSignWarn = { fg = p.bright_yellow },
    DiagnosticSignInfo = { fg = p.bright_blue },
    DiagnosticSignHint = { fg = p.bright_aqua },
    DiagnosticSignOk = { fg = p.bright_green },
    DiagnosticFloatingOk = { fg = p.bright_green },
    -------------------------------------------------
    -- neotree
    -------------------------------------------------
    NeoTreeIndentMarker = { fg = p.bright_blue },
    NeoTreeWinSeparator = { fg = p.dark0, bg = p.off },
    NeoTreeMessage = { link = "NeoTreeDotfile" },
    NeoTreeNormal = { bg = p.off },
    NeoTreeNormalNC = { link = "NeoTreeNormal" },
    NeoTreeDotfile = { fg = p.bright_blue },
    NeoTreeDotfiles = { link = "NeoTreeDotfile" },
    NeoTreeTabActive = { fg = p.off, bg = p.bright_blue, bold = true },
    NeoTreeTabInactive = { fg = p.bright_blue, bg = p.off },
    NeoTreeTabSeparatorActive = { fg = p.bright_blue, bg = p.bright_blue },
    NeoTreeTabSeparatorInactive = { link = "NeoTreeWinSeparator" },
    NeoTreeTitleBar = { link = "NeoTreeTabActive" },
    NeoTreeFloatNormal = { bg = p.off },
    NeoTreeFloatBorder = { fg = p.bright_blue, bg = p.off },
    -------------------------------------------------
    -- bufferline
    -------------------------------------------------
    BufferLineBackground = { bg = p.off, fg = p.gray },
    BufferLineBuffer = { bg = p.off, fg = p.gray },
    BufferLineBufferSelected = { bg = p.off, fg = p.bright_blue },
    BufferLineBufferVisible = { bg = p.off, fg = p.gray },
    BufferLineCloseButton = { bg = p.off, fg = p.bright_red },
    BufferLineCloseButtonSelected = { bg = p.off, fg = p.bright_red },
    BufferLineCloseButtonVisible = { bg = p.off, fg = p.bright_red },
    BufferLineDevIconDefault = { bg = p.off },
    BufferLineDevIconDefaultInvactive = { bg = p.off },
    BufferLineDevIconDefaultSelected = { bg = p.off },
    BufferLineDiagnostic = { bg = p.off, fg = p.gray },
    BufferLineDiagnosticSelected = { bg = p.off, fg = p.gray },
    BufferLineDiagnosticVisible = { bg = p.off, fg = p.gray },
    BufferLineDuplicate = { bg = p.off, fg = p.gray },
    BufferLineDuplicateSelected = { bg = p.off, fg = p.gray },
    BufferLineDuplicateVisible = { bg = p.off, fg = p.gray },
    BufferLineError = { bg = p.off, fg = p.bright_red },
    BufferLineErrorDiagnostic = { bg = p.off, fg = p.bright_red },
    BufferLineErrorDiagnosticSelected = { bg = p.off, fg = p.bright_red },
    BufferLineErrorDiagnosticVisible = { bg = p.off, fg = p.bright_red },
    BufferLineErrorSelected = { bg = p.off, fg = p.bright_red },
    BufferLineErrorVisible = { bg = p.off, fg = p.bright_red },
    BufferLineFill = { bg = p.off_alt, fg = p.gray },
    BufferLineGroupLabel = { bg = p.off, fg = p.gray },
    BufferLineGroupSeparator = { bg = p.off, fg = p.bright_green },
    BufferLineHint = { bg = p.off, fg = p.bright_aqua },
    BufferLineHintDiagnostic = { bg = p.off, fg = p.bright_aqua },
    BufferLineHintDiagnosticSelected = { bg = p.off, fg = p.bright_aqua },
    BufferLineHintDiagnosticVisible = { bg = p.off, fg = p.bright_aqua },
    BufferLineHintSelected = { bg = p.off, fg = p.bright_aqua },
    BufferLineHintVisible = { bg = p.off, fg = p.bright_aqua },
    BufferLineIndicatorSelected = { bg = p.off, fg = p.gray },
    BufferLineIndicatorVisible = { bg = p.off, fg = p.gray },
    BufferLineInfo = { bg = p.off, fg = p.bright_blue },
    BufferLineInfoDiagnostic = { bg = p.off, fg = p.bright_blue },
    BufferLineInfoDiagnosticSelected = { bg = p.off, fg = p.bright_blue },
    BufferLineInfoDiagnosticVisible = { bg = p.off, fg = p.bright_blue },
    BufferLineInfoSelected = { bg = p.off, fg = p.bright_blue },
    BufferLineInfoVisible = { bg = p.off, fg = p.bright_blue },
    BufferLineModified = { bg = p.off, fg = p.gray },
    BufferLineModifiedSelected = { bg = p.off, fg = p.gray },
    BufferLineModifiedVisible = { bg = p.off, fg = p.gray },
    BufferLineNumbers = { bg = p.off, fg = p.gray },
    BufferLineNumbersSelected = { bg = p.off, fg = p.gray },
    BufferLineNumbersVisible = { bg = p.off, fg = p.gray },
    BufferLineOffsetSeparator = { bg = p.off, fg = p.gray },
    BufferLinePick = { bg = p.off, fg = p.gray },
    BufferLinePickSelected = { bg = p.off, fg = p.gray },
    BufferLinePickVisible = { bg = p.off, fg = p.gray },
    BufferLineSeparator = { bg = p.off, fg = p.gray },
    BufferLineSeparatorSelected = { bg = p.off, fg = p.gray },
    BufferLineSeparatorVisible = { bg = p.off, fg = p.gray },
    BufferLineTab = { bg = p.off, fg = p.gray },
    BufferLineTabClose = { bg = p.off, fg = p.gray },
    BufferLineTabSelected = { bg = p.off, fg = p.gray },
    BufferLineTabSeparator = { bg = p.off, fg = p.gray },
    BufferLineTabSeparatorSelected = { bg = p.off, fg = p.gray },
    BufferLineTruncMarker = { bg = p.off, fg = p.gray },
    BufferLineWarning = { bg = p.off, fg = p.bright_yellow },
    BufferLineWarningDiagnostic = { bg = p.off, fg = p.bright_yellow },
    BufferLineWarningDiagnosticSelected = { bg = p.off, fg = p.bright_yellow },
    BufferLineWarningDiagnosticVisible = { bg = p.off, fg = p.bright_yellow },
    BufferLineWarningSelected = { bg = p.off, fg = p.bright_yellow },
    BufferLineWarningVisible = { bg = p.off, fg = p.bright_yellow },
  },
  dim_inactive = false,
  transparent_mode = true,
})

api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWinEnter", "BufRead" }, {
  pattern = "*",
  callback = function()
    if g.colors_name ~= "gruvbox" then
      return
    end
    local icon_ok, web_devicons = pcall(require, "nvim-web-devicons")
    if not icon_ok then
      return
    end
    local filename = fn.expand("%:t")
    local ext = fn.expand("%:e")
    local _, icon_name = web_devicons.get_icon(filename, ext, { default = true })
    local _, icon_color = web_devicons.get_icon_color(filename, ext, { default = true })
    if not icon_name then
      return
    end
    for hl_group, hl_group_opt in pairs({
      ["BufferLine" .. icon_name .. "Selected"] = {
        bg = p.off,
        fg = icon_color,
      },
      ["BufferLine" .. icon_name] = {
        bg = p.off,
        fg = icon_color,
      },
      ["BufferLine" .. icon_name .. "Inactive"] = {
        bg = p.off,
        fg = icon_color,
      },
    }) do
      local link = hl_group_opt.link
      if link ~= nil then
        api.nvim_command("hi! link " .. hl_group .. " " .. link)
        return
      end
      api.nvim_set_hl(0, hl_group, hl_group_opt)
    end
  end,
})

cmd("colorscheme gruvbox")
