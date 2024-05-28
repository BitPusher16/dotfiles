
-- TODO:
-- for now, i don't know how to loop over all files in a directory and assemble them into a table.
-- so all plugin configs must live in a single file.

-- how do i require all lua files in a directory?
-- hint here:
-- https://stackoverflow.com/questions/53991297/how-do-i-use-external-files-as-tables-in-lua
-- and here:
-- https://stackoverflow.com/questions/46377685/load-several-lua-modules-with-single-require

--package.path = package.path .. ';./plugins/?.lua'
--local pgins = {}
--for filename in io.popen('ls -pUqAL "plugins"'):lines() do
--	filename = filename:match'^(.*)%.lua$'
--	if filename then
--		local tmp = require(filename)
--		table.insert(pgins, tmp)
--	end
--end

return {
	{
		'nvim-tree/nvim-web-devicons',
--		config = function()
--			require('nvim-web-devicons').setup()
--		end,
	},
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('nvim-tree').setup()
		end,
	},
	{
		'alexghergh/nvim-tmux-navigation',
--		config = function()
--			require('nvim-tmux-navigation').setup({
--			    disable_when_zoomed = true,
--			    keybindings = {
--				left = '<C-h>',
--				right = '<C-l>',
--				up = '<C-k>',
--				down = '<C-j>',
--			    }
--			})
--		end
	},
}
