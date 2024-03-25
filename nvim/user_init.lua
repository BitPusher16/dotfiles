-- to activate this file, add these lines to ~/.config/nvim/init.lua:
-- package.path = "/home/<user>/src/dotfiles/nvim/?.lua;" .. package.path
-- require("user_init")

-- refer to this page for info on how lua require statements work:
-- https://www.lua.org/pil/8.1.html

--package.path = "?/init.lua;" .. package.path
require("conf1/init") -- relative lines

vim.opt.number = true
vim.opt.colorcolumn = "80"
-- set matching parent to no highlight so it is not visually confusing.
vim.cmd [[:highlight MatchParen cterm=underline ctermfg=NONE ctermbg=NONE]]
-- keep cursor centered if possible
vim.opt.scrolloff = 999

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- run 'M' command on document open to center cursor.
-- command is created in an autogroup for cleanup per recommendation here:
-- https://neovim.io/doc/user/usr_40.html#40.3
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

Plug('nvim-tree/nvim-tree.lua')
--Plug('nvim-tree/nvim-web-devicons')

Plug('dstein64/nvim-scrollview')

--Plug('el-iot/buffer-tree-explorer')

Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
vim.call('plug#end')

-- ==========
-- plugin configs
-- ==========

-- nvim-tree configs
require('nvim-tree').setup()
--require('nvim-web-devicons').setup()

require('scrollview').setup{
	current_only = true
}
-- set scrollbar color
-- :help scrollview
vim.cmd [[highlight Scrollview ctermbg=Red]]

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
lspconfig.clangd.setup{}

-- ==========
-- key remaps
-- ==========

-- keep this section last, so remaps can apply to plugins.
-- where possible, map key sequences (leader -> key)
-- rather than combinations (leader + key).
-- left ctrl and right ctrl are awkward to reach.

