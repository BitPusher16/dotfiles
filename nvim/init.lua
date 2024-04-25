-- ========
-- notes
-- ========

-- to activate this file, add these lines to ~/.config/nvim/init.lua:
-- package.path = "/home/<user>/src/dotfiles/nvim/?.lua;" .. package.path
-- require("init")

-- to source (may not unload existing autogroups):
-- :so ~/.config/nvim/init.lua

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
package.path = home .. '/src/dotfiles/nvim/?.lua;' .. package.path
require('conf/status_line')

-- ========
-- vim opt
-- ========

vim.opt.number = true
vim.opt.colorcolumn = "81"
--vim.cmd( ":hi ColorColumn ctermbg=cyan" )
--vim.cmd( ":hi ColorColumn ctermbg=lightgray" )
vim.cmd( ":hi ColorColumn ctermbg=white" )

-- keep cursor centered if possible
vim.opt.scrolloff = 999

-- allow copy and paste with system clipboard.
vim.opt.clipboard = 'unnamedplus'

-- these configs are recommended by the nvim-tree docs.
-- they must appear before nvim-tree is loaded (or is initialized?).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--vim.opt.termguicolors = true -- 24 bit color, but hides 16-bit color.



-- ========
-- plugins
-- ========

-- using vim-plug as plugin manager
-- https://github.com/junegunn/vim-plug

-- :PlugStatus
-- :PlugUpdate
-- (how to install/uninstall after updating plugin list without restarting?)

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('nvim-tree/nvim-tree.lua')

Plug('dstein64/nvim-scrollview')

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

require('nvim-tree').setup()
vim.cmd( ":hi link NvimTreeNormalFloat SpellLocal" )
vim.cmd( ":hi link NvimTreeCursorColumn SpellLocal" )
vim.cmd( ":hi link NvimTreeStatusLine Statusline" )
vim.cmd( ":hi link NvimTreeStatusLineNC StatusLineNC" )
vim.cmd( ":hi link NvimTreeExecFile SpellLocal" )
vim.cmd( ":hi link NvimTreeImageFile SpellLocal" )
vim.cmd( ":hi link NvimTreeSpecialFile SpellLocal" )
vim.cmd( ":hi link NvimTreeSymlink SpellLocal" )
vim.cmd( ":hi link NvimTreeCutHL SpellLocal" )
vim.cmd( ":hi link NvimTreeCopiedHL SpellLocal" )

vim.cmd( ":hi clear NvimTreeWindowPicker")
vim.cmd( ":hi link NvimTreeWindowPicker SpellLocal" )


require('scrollview').setup{
	current_only = true
}
-- set scrollview bar color
-- :help scrollview
-- https://github.com/dstein64/nvim-scrollview/blob/main/doc/scrollview.txt
vim.cmd [[highlight Scrollview ctermbg=cyan]]


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

lspconfig.pylsp.setup{}

-- nvim-lspconfig key remaps
-- copied from ___?

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

-- by default, leader is "\".

-- https://neovim.io/doc/user/lua-guide.html
-- Mappings can be created using vim.keymap.set(). 
-- This function takes three mandatory arguments:

-- Can we instead just use vim.cmd(":... ")?

-- add a shortcut to delete current buffer but leave pane open.
--vim.cmd(":map <leader>x :bp<bar>sp<bar>bn<bar>bd<CR>")
-- alternative (doesn't work with NvimTree open):
--vim.cmd(":map <leader>x :window b#<bar>bd#<CR>")
vim.cmd(":map <leader>x :b#<bar>bd#<CR>")
--vim.cmd(":command! Bd bp<bar>sp<bar>bn<bar>bd<CR>")

-- unmap some unuseful ctrl key combinations for use later.
--vim.cmd(":unmap <C-c>") -- does same thing as esc
--vim.cmd(":unmap <C-f>") -- prints file name and status, also available with :f

--vim.cmd(":nnoremap <C-H> <C-W>h")
--vim.cmd(":nnoremap <C-J> <C-W>j")
--vim.cmd(":nnoremap <C-K> <C-W>k")
--vim.cmd(":nnoremap <C-L> <C-W>l")

-- ========
-- autogroups
-- ========

-- run 'M' command on document open to center cursor.
-- command is created in an autogroup for cleanup per recommendation here:
-- https://neovim.io/doc/user/usr_40.html#40.3

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup('CenterOnStart', {clear = true})
autocmd('BufReadPost', {
	group = 'CenterOnStart',
	pattern = '',
	command = ':execute "normal M"'
})

-- 2024-04-24
-- can't get nvim wrap option to propagate to NvimTree after startup.
-- but the autocommand below effectively does the same thing...

vim.api.nvim_create_autocmd(
	{
		--"BufAdd", "BufNew", "BufRead", "BufFilePre", "BufFilePost",
		--"BufEnter", "BufWinEnter", "BufLeave", "BufWinLeave"
		"BufEnter", "BufLeave"
		--"FileType"
	},
	{
		--pattern={"NvimTree"},
		command = "setlocal wrap",
	}
)

-- ========
-- highlights
-- ========

-- set colors for command mode tab completion.
vim.cmd( ":hi Pmenu ctermbg=cyan guibg=lightgray" )
vim.cmd( ":hi PmenuSel ctermbg=yellow guibg=lightgray" )

-- set matching paren to no highlight so it is not visually confusing.
vim.cmd [[:highlight MatchParen cterm=underline ctermfg=NONE ctermbg=NONE]]

vim.cmd( ":hi Visual cterm=NONE ctermbg=cyan ctermfg=black")
vim.cmd( ":hi Search cterm=NONE ctermbg=yellow ctermfg=black")

vim.cmd(":hi Statusline cterm=bold ctermfg=black ctermbg=cyan")
vim.cmd(":hi StatusLineNC cterm=bold ctermfg=black ctermbg=lightgray")

vim.cmd(":hi StatusLineExtra cterm=bold ctermfg=black ctermbg=cyan")
vim.cmd(":hi StatusLineExtraNC cterm=bold ctermfg=black ctermbg=lightgray")
