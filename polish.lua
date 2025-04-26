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

-- neovim no longer needs a separate program to copy paste from system clipboard.
-- https://neovim.io/doc/user/provider.html
-- https://www.reddit.com/r/neovim/comments/1e9vllk/neovim_weird_issue_when_copypasting_using_osc_52/
-- note: pressing "p" will still use a register, not pull from system clipboard.
-- update, here is why: https://neovim.io/doc/user/provider.html#_paste
-- that's not great, because y (yank) writes to clipboard, but p doesn't paste from clipboard. ctrl+shift+v is required.
-- hint: use :reg to see register contents
-- update 2025-02-23. I've given up on solving copy-paste using out-of-the box neovim functionality.
-- setting clipboard to "unnamedplus" and install wl-clipboard with apt solves everything.
-- well, mostly. copying text in another app and attempting to "put" with "p" doesn't work very well. need ctrl+shift+v.
-- not sure what to do. a few posting online say that osc52 is restricted in windows.
-- update 2025-02-23. I have native neovim osc 52 support working with kitty.
-- I've found the configs that prevent pop-ups when pasting using osc 52.
-- However, unfortunately Zellij doesn't understand the Kitty warning signal (even though disabled),
-- so when putting with "p", neovim hangs and requires ctrl-c.
--
-- apple
-- apple
-- apple
--

vim.o.clipboard = "unnamedplus"

local function paste() -- this is poorly named. ctrl+shift+v is paste. this is get register.
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"), -- note: split() drops leading newlines.
		vim.fn.getregtype(""),
	}
end

--local function my_paste()
--	return vim.fn.split(vim.fn.getreg("*"), "\n")
--end

--local function clip_paste()
--	return {
--		vim.fn.getreg(""),
--	}
--end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		--["+"] = my_paste,
		--["*"] = my_paste,

		--["+"] = paste,
		--["*"] = paste,

		--[""] = paste, -- also use paste function for undefined register.

		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

--vim.paste = clip_paste

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
