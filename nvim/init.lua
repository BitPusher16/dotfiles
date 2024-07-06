-- ========
-- notes
-- ========

-- to activate this file, add these lines to ~/.config/nvim/init.lua:
-- package.path = '/home/<user>/src/dotfiles/nvim/?.lua;' .. package.path
-- require('init')

-- to source:
-- :so ~/.config/nvim/init.lua
-- or:
-- :so %
-- note: may not source autogroups. (?)
-- note: also may not reload 'require' statements.

-- note:
-- installing vim-plug requires downloading plug.vim to
-- ~/.local/share/nvim/site/autoload

-- this page has a recommendation for nvim lua config file structure:
-- https://neovim.io/doc/user/lua-guide.html

--   ~/.config/nvim
--  |-- after/
--  |-- ftplugin/
--  |-- lua/
--  |   |-- myluamodule.lua
--  |   |-- other_modules/
--  |       |-- anothermodule.lua
--  |       |-- init.lua
--  |-- plugin/
--  |-- syntax/
--  |-- init.vim

-- refer to this page for info on how lua require statements work:
-- https://www.lua.org/pil/8.1.html

-- refer to this page for lua autocommands:
-- https://neovim.io/doc/user/lua-guide.html#lua-guide-autocommands

-- ========
-- requires
-- ========

local home = os.getenv('HOME')
--package.path = home .. '/src/dotfiles/nvim/?.lua;' .. package.path
package.path = package.path .. ';' .. home .. '/src/dotfiles/nvim/?.lua;'
--require('conf/status_line')
--require('conf/highlight')
--require('conf/subdir_example')
--require('status_line') # deprecated, using lualine now.
require('vim_plug')
require('autocommands')
require('vim_opt')
require('key_remaps')
require('highlight')

