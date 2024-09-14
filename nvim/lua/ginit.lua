-- options
--

vim.g.neovide_transparency = vim.g.gui_transparency_default
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_touch_drag_timeout = 0.20
vim.g.remember_window_size = true
vim.g.remember_window_position = true
vim.g.gui_font_default_size = 15
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "CaskaydiaCove NF"
vim.opt.linespace = 0

-- utils
--

local function toggle_fullscreen()
  if vim.g.neovide_fullscreen == false then
    vim.cmd("let g:neovide_fullscreen=v:true")
  else
    vim.cmd("let g:neovide_fullscreen=v:false")
  end
end

local function refresh_gui_font()
  vim.o.guifont = string.format("%s:h%s:w-0.4:#e-subpixelantialias:#h-normal", vim.g.gui_font_face, vim.g.gui_font_size)
end

local function resize_gui_font(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  refresh_gui_font()
end

local function reset_gui_font()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  refresh_gui_font()
end

-- keymaps
--

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "i" },    "<F12>",    function() resize_gui_font(1) end,  opts)
vim.keymap.set({ "n", "i" },    "<F11>",    function() resize_gui_font(-1) end, opts)
vim.keymap.set({ "n", "i" },    "<F10>",    function() reset_gui_font() end,    opts)
vim.keymap.set({ "n" },         "<F8>",     toggle_fullscreen, opts)

-- reset
--

reset_gui_font()
