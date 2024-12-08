return {
  "pechorin/any-jump.vim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<Leader>a"] = {
          desc = "󱋿 Any Jump",
        }
        maps.n["<Leader>aj"] = {
          [[<cmd>AnyJump<cr>]],
          desc = "Jump to definition under cursor",
        }
        maps.n["<Leader>ab"] = {
          [[<cmd>AnyJumpBack<cr>]],
          -- desc = "Open previous opened file (after jump)",
          desc = "Open previous opened file",
        }
        maps.n["<Leader>al"] = {
          [[<cmd>AnyJumpLastResults<cr>]],
          desc = "Open last closed search window again",
        }
        maps.x["<Leader>a"] = {
          desc = "󱋿 Any Jump",
        }
        maps.x["<Leader>aj"] = {
          [[<cmd>AnyJumpVisual<cr>]],
          desc = "Jump to definition under cursor",
        }
      end,
    },
  },
}
