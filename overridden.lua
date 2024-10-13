-- to add this config to astronvim settings, replace the contents of 
-- ~/.config/nvim/lua/plugs/overridden.lua with these two lines:
-- dofile('/home/<username>/src/dotfiles/overridden.lua')
-- return ASTRONVIM_DOTFILE_CONFIG

ASTRONVIM_DOTFILE_CONFIG = {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },

      --
      --termguicolors = false,
      --colorscheme = "default",

    },
  },
  --{
  --  "AstroNvim/astrocore",
  --  opts = function(_, opts)
  --    local maps = opts.mappings
  --    maps.n["<Leader>bn"] = {function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Next buffer"}
  --  end
  --},
}
