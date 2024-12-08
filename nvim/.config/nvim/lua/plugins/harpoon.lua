return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        maps.n["<Leader><Leader>e"] = {
          function()
            require("harpoon").ui:toggle_quick_menu(
              require("harpoon"):list(),
              { title = " Harpoon ", title_pos = "center", border = "rounded" }
            )
          end,
          desc = "Toggle quick menu",
        }
      end,
    },
  },
  opts = {
    default = {
      display = function(list_item)
        local function shortenPathWithFirstLetter(path)
          local components = {}
          for component in path:gmatch "([^/\\]+)" do
            table.insert(components, component)
          end
          for i = 1, #components - 1 do
            components[i] = components[i]:sub(1, 1)
          end
          return table.concat(components, "/")
        end
        return shortenPathWithFirstLetter(list_item.value)
      end,
    },
  },
}
