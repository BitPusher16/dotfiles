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

vim.opt.clipboard = 'unnamedplus'

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

-- nvim-tree configs.
-- run :NvimTreeHiTest to see example highlights.
-- example nvim lua setup:
-- https://gitee.com/kongjun18/nvim-tree.lua
-- Run |:NvimTreeHiTest| to show all the highlights 
-- that nvim-tree uses.
-- They can be customised before or after setup is called and 
-- will be immediately applied at runtime. e.g. >

--require('nvim-tree').setup()
require('nvim-tree').setup()
vim.cmd( ":hi link NvimTreeNormalFloat SpellLocal" )
vim.cmd( ":hi link NvimTreeCursorColumn SpellLocal" )
vim.cmd( ":hi link NvimTreeStatusLine SpellLocal" )
vim.cmd( ":hi link NvimTreeStatusLineNC SpellLocal" )
vim.cmd( ":hi link NvimTreeExecFile SpellLocal" )
vim.cmd( ":hi link NvimTreeImageFile SpellLocal" )
vim.cmd( ":hi link NvimTreeSpecialFile SpellLocal" )
vim.cmd( ":hi link NvimTreeSymlink SpellLocal" )
vim.cmd( ":hi link NvimTreeCutHL SpellLocal" )
vim.cmd( ":hi link NvimTreeCopiedHL SpellLocal" )

vim.cmd( ":hi clear NvimTreeWindowPicker")
vim.cmd( ":hi link NvimTreeWindowPicker SpellLocal" )

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
  ensure_installed = {'lua_ls', 'bashls', 'clangd'
    --,'jedi_language_server'
    ,'pylsp'
  }
}
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup{
  -- https://neovim.discourse.group/t/
  -- how-to-suppress-warning-undefined-global-vim/1882/3
  settings = { Lua = { diagnostics = { globals = {'vim'} } } }
}
lspconfig.clangd.setup{}
--lspconfig.jedi_language_server.setup{}
lspconfig.pylsp.setup{}

-- ==========
-- nvim-lspconfig key remaps
-- ==========

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- ==========
-- key remaps
-- ==========

-- keep this section last, so remaps can apply to plugins.
-- where possible, map key sequences (leader -> key)
-- rather than combinations (leader + key).
-- left ctrl and right ctrl are awkward to reach.


