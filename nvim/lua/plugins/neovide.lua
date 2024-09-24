if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        guifont = "CaskaydiaCove NF:h15:w-0.5:#e-subpixelantialias:#h-normal",
        -- line spacing
        linespace = 0,
      },
      g = { -- configure vim.g variables
        neovide_scale_factor = 1.0,
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
        neovide_transparency = vim.g.gui_transparency_default,
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_cursor_vfx_opacity = 500.0,
        neovide_cursor_vfx_particle_lifetime = 4.0,
        neovide_cursor_vfx_particle_density = 32.0,
        neovide_cursor_vfx_particle_speed = 16.0,
        neovide_cursor_animation_length = 0.08,
      },
    },
  },
}
