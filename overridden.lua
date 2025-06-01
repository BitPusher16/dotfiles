-- to add this config to astronvim settings, replace the contents of
-- ~/.config/nvim/lua/plugins/overridden.lua with these two lines:
-- dofile('/home/<username>/src/dotfiles/overridden.lua')
-- return ASTRONVIM_DOTFILE_CONFIG
-- TODO: see if i can run return from git repo overridden.lua, and not need it in ~/.config.

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

	--{
	--	"AstroNvim/astrotheme",
	--	enabled = false,
	--},

	--{
	--	"AstroNvim/astroui",
	--	---@type AstroUIOpts
	--	opts = {
	--		--colorscheme = "astrolight",
	--		colorscheme = "astrodark",
	--	},
	--},

	{
		"AstroNvim/astrotheme",
		-- https://github.com/AstroNvim/astrotheme/blob/main/lua/astrotheme/palettes/astrodark.lua
		opts = {
			--palette = "astrodark",
			palettes = {
				astrodark = {
					ui = {
						--red = "#e31a1c",
						red = "#cc6666",
						orange = "#dca060",
						yellow = "#dca060",
						green = "#31a354",
						cyan = "#80b1d3",
						blue = "#3182bd",
						purple = "#756bb1",

						--accent = "#756bb1",

						--tabline = "#756bb1",
						--winbar = "#756bb1",
						--tool = "#756bb1",
						--base = "#756bb1",
						--inactive_base = "#756bb1",
						--statusline = "#756bb1",
						--split = "#756bb1",
						--float = "#756bb1",
						--title = "#756bb1",
						--border = "#756bb1",
						--current_line = "#756bb1",
						--scrollbar = "#756bb1",
						--selection = "#756bb1",
						--highlight = "#756bb1",
						--none_text = "#756bb1",
						--text_active = "#756bb1",
						--text_inactive = "#756bb1",
						--text_match = "#756bb1",
					},
					syntax = {
						--red = "#e31a1c",
						red = "#cc6666",
						orange = "#dca060",
						yellow = "#dca060",
						green = "#31a354",
						cyan = "#80b1d3",
						blue = "#3182bd",
						purple = "#756bb1",
						text = "#b7b8b9",
						comment = "#737475",
						mute = "#737475",
					},
					term = {
						--black = "#cc6666",
						--bright_black = "#cc6666",
						--red = "#cc6666",
						--bright_red = "#cc6666",
						--green = "#cc6666",
						--bright_green = "#cc6666",
						--yellow = "#cc6666",
						--bright_yello = "#cc6666",
						--blue = "#cc6666",
						--bright_blue = "#cc6666",
						--purple = "#cc6666",
						--bright_purple = "#cc6666",
						--cyan = "#cc6666",
						--bright_cyan = "#cc6666",
						--white = "#cc6666",
						--bright_white = "#cc6666",
						--background = "#cc6666",
						--foreground = "#cc6666",
					},
					icon = {
						--vimrc = "#e31a1c",
						bashrc = "#80b1d3",
						lua = "#756bb1",
					},
				},
			},
		},
	},

	-- super cool! listing a plugin here causes lazy.nvim to download and use.
	-- unfortunately, it seems that astronvim is not deterministic about plugin order?
	-- re-opening nvim randomly corrupts colors if this is turned on.
	--{
	--	"echasnovski/mini.base16",
	--	init = function()
	--		require("mini.base16").setup({
	--			plugins = {
	--				false,
	--			},
	--			palette = {
	--				base00 = "#0c0d0e",
	--				base01 = "#737472",
	--				base02 = "#31a354",
	--				base03 = "#dca060",
	--				base04 = "#3182bd",
	--				base05 = "#756bb1",
	--				base06 = "#80b1d3",
	--				base07 = "#b7b8b9",
	--				base08 = "#737475",
	--				base09 = "#be95f1",
	--				base0A = "#31a354",
	--				base0B = "#dca060",
	--				base0C = "#3182bd",
	--				base0D = "#756bb1",
	--				base0E = "#80b1d3",
	--				base0F = "#fcfdfe",
	--			},
	--		})
	--	end,
	--},

	--{
	--	"AstroNvim/astrocommunity",
	--	{
	--		import = "astrocommunity.coloscheme.mini.base16",
	--	},
	--},

	--{
	--	"AstroNvim/astroui",
	--	---@type AstroUIOpts
	--	opts = {
	--		colorscheme = "nvim.base16",
	--	},
	--},
}
