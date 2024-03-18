-- to activate this file, add these lines to ~/.config/nvim/init.lua:
-- package.path = "/home/<user>/src/dotfiles/nvim/?.lua;" .. package.path
-- require("misc")

-- refer to this page for info on how lua require statements work:
-- https://www.lua.org/pil/8.1.html

--package.path = "?/init.lua;" .. package.path
require("conf1/init") -- relative lines

vim.opt.number = true
vim.opt.colorcolumn = "80"
-- keep cursor centered if possible
vim.opt.scrolloff = 999

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- run 'M' command on document open to center cursor.
augroup('CenterOnStart', {clear = true})
autocmd('BufReadPost', {
	group = 'CenterOnStart',
	pattern = '',
	command = ':execute "normal M"'
})

-- these configs are recommended by the nvim-tree docs
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 24-bit color. but disconnects nvim from terminal emulator colors.
--vim.opt.termguicolors = true	

-- ==========
-- plugins
-- ==========

-- using vim-plug as plugin manager
-- https://github.com/junegunn/vim-plug
local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('psliwka/vim-smoothie')
Plug('nvim-tree/nvim-tree.lua')
--Plug('nvim-tree/nvim-web-devicons')

--Plug('el-iot/buffer-tree-explorer')

Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
vim.call('plug#end')

-- ==========
-- plugin configs
-- ==========

--require('vim-smoothie').setup()

-- nvim-tree configs
require('nvim-tree').setup()
--require('nvim-web-devicons').setup()

-- https://github.com/williamboman/mason-lspconfig.nvim#setup
require('mason').setup()
require('mason-lspconfig').setup{
  ensure_installed = {'lua_ls', 'bashls', 'clangd'}
}
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup{
  -- https://neovim.discourse.group/t/
  -- how-to-suppress-warning-undefined-global-vim/1882/3
  settings = { Lua = { diagnostics = { globals = {'vim'} } } }
}

-- ==========
-- key remaps
-- ==========

-- keep this section last, so remaps can apply to plugins.
-- where possible, map key sequences (leader -> key)
-- rather than combinations (leader + key).
-- left ctrl and right ctrl are awkward to reach.

