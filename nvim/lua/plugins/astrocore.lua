---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = false,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      o = {
        foldcolumn = "0",
      },
      opt = {
        termguicolors = false,
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "no",
        wrap = false,
        guifont = "JetBrainsMono NF:h11:#e-subpixelantialias:#h-normal",
        linespace = 0,
        shell = "fish",
        laststatus = 0,
        colorcolumn = { 80, 120 },
        fillchars = {
          horiz = "━",
          horizup = "┻",
          horizdown = "┳",
          vert = "┃",
          vertleft = "┫",
          vertright = "┣",
          verthoriz = "╋",
          eob = " ",
          foldopen = "",
          foldclose = "",
        },
        list = false,
        listchars = {
          eol = "¶",
          tab = "» ",
          extends = "›",
          precedes = "‹",
          trail = "~",
          space = "•",
        },
      },
      g = {
        neovide_floating_shadow = false,
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
        moonflyWinSeparator = 2,
      },
    },
    mappings = {
      n = {
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        ["<c-w>>"] = { [[<cmd>vertical resize +5<cr>]], desc = "Increase width" },
        ["<c-w><"] = { [[<cmd>vertical resize -5<cr>]], desc = "Decrease width" },
        ["<c-w>+"] = { [[<cmd>horizontal resize +5<cr>]], desc = "Increase height" },
        ["<c-w>-"] = { [[<cmd>horizontal resize -5<cr>]], desc = "Decrease height" },

        ["<Leader>uZ"] = { [[<cmd>ZenMode<cr>]], desc = "Toggle ZenMode" },

        ["<Leader><Leader>e"] = {
          function()
            require("harpoon").ui:toggle_quick_menu(
              require("harpoon"):list(),
              { title = " Quick Search ", title_pos = "center", border = "rounded" }
            )
          end,
          desc = "Toggle quick menu",
        },

        ["<Leader>uz"] = {
          require("toggles").clean_mode,
          desc = "Toggle 'Clean Mode'",
        },
      },
    },
  },
}
