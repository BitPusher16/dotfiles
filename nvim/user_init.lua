-- to activate this file, add these lines to ~/.config/nvim/init.lua:
-- package.path = "/home/<user>/src/dotfiles/nvim/?.lua;" .. package.path
-- require("misc")

-- refer to this page for info on how lua require statements work:
-- https://www.lua.org/pil/8.1.html

--package.path = "?/init.lua;" .. package.path
require("conf1/init") -- relative lines

vim.opt.number = true
vim.opt.colorcolumn = "80"

-- using vim-plug as plugin manager
-- https://github.com/junegunn/vim-plug
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('nvim-tree/nvim-tree.lua')
vim.call('plug#end')
