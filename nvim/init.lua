require("misc") -- lua (or nvim?) knows to look in the lua dir for modules.


local Plug = vim.fn['plug#']

vim.call('plug#begin')

--Plug 'tpope/vim-sensible'
--Plug('junegunn/goyo.vim', {['for'] = 'markdown'})
--Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-tree/nvim-tree.lua')
--Plug('preservim/nerdtree')

--Plug('folke/tokyonight.nvim')


-- https://github.com/VonHeikemen/lsp-zero.nvim
-- Uncomment the two plugins below if you want to manage the language servers from neovim
Plug ('williamboman/mason.nvim')
Plug ('williamboman/mason-lspconfig.nvim')
-- LSP Support
Plug ('neovim/nvim-lspconfig')
-- Autocompletion
Plug ('hrsh7th/nvim-cmp')
Plug ('hrsh7th/cmp-nvim-lsp')
Plug ('L3MON4D3/LuaSnip')
Plug ('VonHeikemen/lsp-zero.nvim', {['branch']= 'v3.x'})

vim.call('plug#end')

local o = vim.opt
local g = vim.g
--o.number = true

-- copy text to system clipboard
--vim.opt.clipboard = 'unnamed,unnamedplus'

-- Nvim Tree recommends the following settings.
-- https://github.com/nvim-tree/nvim-tree.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
o.background = 'light'
--o.termguicolors = true
--o.colorscheme = 'default'
require('nvim-tree').setup()

--vim.cmd[[colorscheme tokyonight]]
--vim.cmd[[colorscheme slate]]
vim.cmd[[colorscheme default]] -- using default (or none) just uses terminal colors?

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- here you can setup the language servers 

--local lspconfig = require('lspconfig')
--lspconfig.lua_ls.setup{

--require('lspconfig').lua_ls.setup {
--  -- settings taken from https://github.com/neovim/neovim/issues/21686
--  -- these settings required to remove 'undefined global vim' error?
--  settings = {
--    Lua = {
--      runtime = {
--        -- Tell the language server which version of Lua you're using
--        -- (most likely LuaJIT in the case of Neovim)
--        version = 'LuaJIT',
--      },
--      diagnostics = {
--        -- Get the language server to recognize the `vim` global
--        globals = {
--          'vim',
--          'require'
--        },
--      },
--      workspace = {
--        -- Make the server aware of Neovim runtime files
--        library = vim.api.nvim_get_runtime_file("", true),
--      },
--      -- Do not send telemetry data containing a randomized but unique identifier
--      telemetry = {
--        enable = false,
--      },
--    },
--  },
--}




require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed={'rust_analyzer', 'lua_ls', 'pylsp',},
	handlers={
		lsp_zero.default_setup,
		lua_ls = function()
			require('lspconfig').lua_ls.setup {
			  -- settings taken from https://github.com/neovim/neovim/issues/21686
			  -- these settings required to remove 'undefined global vim' error?
			  settings = {
			    Lua = {
			      runtime = {
			        -- Tell the language server which version of Lua you're using
			        -- (most likely LuaJIT in the case of Neovim)
			        version = 'LuaJIT',
			      },
			      diagnostics = {
			        -- Get the language server to recognize the `vim` global
			        globals = {
			          'vim',
			          'require'
			        },
			      },
			      workspace = {
			        -- Make the server aware of Neovim runtime files
			        library = vim.api.nvim_get_runtime_file("", true),
			      },
			      -- Do not send telemetry data containing a randomized but unique identifier
			      telemetry = {
			        enable = false,
			      },
			    },
			  },
			}
		end,
	},
})

