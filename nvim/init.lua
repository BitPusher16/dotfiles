-- to activate this file, add these lines to ~/.config/nvim/init.lua:
-- package.path = '/home/<user>/src/dotfiles/nvim/?.lua;' .. package.path
-- require('init')

package.path = package.path .. ';./?.lua'
--package.path = './?.lua;' .. package.path

require('bootstrap_lazy')

local plugin_table = require('plugin_table')
-- lazy nvim messes up color schemes pretty badly.
-- load a default just in case it does a plugin install on startup.
vim.cmd[[ colorscheme default]]
require('lazy').setup(plugin_table, {
    install = {
        -- some combination of autosession, nvim-tree, and lazy.nvim
        -- makes the colors and layout go haywire.
        -- don't instantly install plugins on startup.
        -- require manual call to install.
        missing = false,
    }
})

require('vim_opt')
require('highlight')
require('key_remaps')


