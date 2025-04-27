-- to add this config to astronvim settings, replace the contents of
-- ~/.config/nvim/lua/plugins/overridden.lua with these two lines:
-- dofile('/home/<username>/src/dotfiles/overridden.lua')
-- return ASTRONVIM_DOTFILE_CONFIG

-- for now, i can't figure out how to get these settings into my git dotfiles.
-- together, they force astronvim to use the 16 ansi terminal colors.
-- astrocore.lua -> options -> opt -> termguicolors = false
-- astroui.lua -> opts -> colorscheme = "default"

--HINT! try:
--:lua =vim.opt.number

ASTRONVIM_DOTFILE_CONFIG = {
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					--visible = true,
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
