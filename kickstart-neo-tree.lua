return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		--{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		-- TODO: consider moving all key maps to the end of main config file?
		-- otherwise, key configs are split across many places.
		{ "<leader>e", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
			},
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
		},
		event_handlers = {
			{
				event = "file_open_requested",
				handler = function()
					-- auto close
					-- vim.cmd("Neotree close")
					-- OR
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
	},
}
