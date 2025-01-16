-- to activate this file, put the following line in ~/.config/nvim/lua/polish.lua:
-- dofile ("/home/<user>/src/dotfiles/polish.lua")

-- https://github.com/neovim/neovim/discussions/28010
-- note: only pressing "p" will not paste
--
--vim.g.clipboard = {
--	name = "OSC 52",
--	copy = {
--		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--	},
--	paste = {
--		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
--		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
--	},
--}

-- https://www.reddit.com/r/neovim/comments/1e9vllk/neovim_weird_issue_when_copypasting_using_osc_52/
vim.o.clipboard = "unnamedplus"

local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}

-- this takes effect, but strips too many colors:
--vim.o.termguicolors = false

--require("astrotheme").setup({
--palette = "brewer_dark",
--require("astroui").setup({
--	highlights = {
--		init = {
--			Normal = {
--				bg = "#000000",
--				fg = "#ffffff",
--				--black = "#000000",
--				--white = "#ffffff",
--				--green = "#00ff00",
--				--blue = "#0000ff",
--				--red = "#ff0000",
--			},
--		},
--	},
--})
