-- ========
-- notes
-- ========

-- to activate this file, add these lines to ~/.config/nvim/init.lua:
-- package.path = '/home/<user>/src/dotfiles/nvim/?.lua;' .. package.path
-- require('init')

-- to source (may not unload existing autogroups):
-- :so ~/.config/nvim/init.lua

-- to add a new plugin:
-- 1) add Plug() call to plugin section.
-- 2) :so %
-- 3) :PlugInstall
-- 4) add call to require('plugin-name')
--      - only need to do this if plugin needs activated. some deps don't.
-- 5) :so %

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
require('conf/subdir_example')
require('status_line')
require('highlight')

-- ========
-- vim opt
-- ========

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "81"
--vim.cmd( ":hi ColorColumn ctermbg=cyan" )
--vim.cmd( ":hi ColorColumn ctermbg=lightgray" )
vim.cmd( ":hi ColorColumn ctermbg=black" )

-- keep cursor centered if possible
vim.opt.scrolloff = 999
--vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"

-- Use autosave instead of swap files.
-- Can't think of any scenario where I would want to keep edits in memory only.
--vim.opt.swapfile = false
vim.opt.swapfile = true

--vim.opt.incsearch = false

--vim.opt.autowriteall = true -- this doesn't save on leaving edit mode...
--vim.cmd( ":autocmd InsertLeave * write" ) -- doesn't save after dd, etc.
--vim.cmd( ":autocmd TextChanged,FocusLost,FocusGained," ..
--    "InsertLeave,BufEnter,BufLeave * silent update")
--vim.cmd( ":autocmd TextChanged * silent update")
--vim.cmd( ":autocmd InsertLeave * silent update")

--local function save_if_modifiable()
--    if vim.api.nvim_get_option('ma') and vim.api.nvim_get_option('write') then
--        --vim.cmd('echo "foo"')
--        vim.cmd('silent update')
--    end
--end
--vim.api.nvim_create_autocmd({ "TextChanged" }, { callback = save_if_modifiable })

-- update: rethinking this. maybe auto saving after every keystroke is bad idea.
--vim.cmd( ":autocmd TextChanged,TextChangedI * silent update")


-- allow copy and paste with system clipboard.
vim.opt.clipboard = 'unnamedplus'

-- these configs are recommended by the nvim-tree docs.
-- they must appear before nvim-tree is loaded (or is initialized?).
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
--vim.opt.termguicolors = true -- 24 bit color, but hides 16-bit color.

-- choosing spaces rather than tabs bc it means my code will
-- display with consistent formatting when pushed to github, etc.
-- note: somehow nvim knows to ignore these settings for makefiles.
-- where is this configured?
vim.opt.tabstop = 4 -- 4 spaces for tabs.
vim.opt.shiftwidth = 4 -- 4 spaces for indent width.
vim.opt.expandtab = true -- expand tab to spaces.
vim.opt.autoindent = true -- copy indent from current line to new one.

vim.opt.backspace = 'indent,eol,start' -- ?

vim.cmd(":set list listchars=tab:»¯,trail:°")

vim.opt.wrap = true
vim.wo.wrap = true
--vim.wo.linebreak = true
--vim.wo.list = false



-- ========
-- plugins
-- ========

-- using vim-plug as plugin manager
-- https://github.com/junegunn/vim-plug

-- note:
-- installing vim-plug requires downloading plug.vim to
-- ~/.local/share/nvim/site/autoload

-- note:
-- https://github.com/junegunn/vim-plug/wiki/faq
-- vim-plug no longer handles dependencies between plugins and it's 
-- up to the user to manually specify Plug commands for dependent plugins


-- :PlugStatus
-- :PlugUpdate
-- (how to install/uninstall after updating plugin list without restarting?)

local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- these are required by neo-tree:
--Plug('nvim-lua/plenary.nvim')
Plug('nvim-tree/nvim-web-devicons') -- nvim-tree uses this
--Plug('muniftanjim/nui.nvim')

-- neo-tree
-- edit: neotree is nice, but causes visible stuttering on startup.
-- nvim-tree is faster.
--Plug('nvim-neo-tree/neo-tree.nvim')

Plug('nvim-tree/nvim-tree.lua')

Plug('nvim-lualine/lualine.nvim')
Plug('folke/which-key.nvim')
-- Use autosave instead of swap files.
-- Can't think of any scenario where I would want to keep edits in memory only.
Plug('folke/flash.nvim')

--Plug('karb94/neoscroll.nvim') # no support for 10k, 10j.
-- TODO: mini has lots of other plugins, check these out.
Plug('echasnovski/mini.animate')

Plug('alexghergh/nvim-tmux-navigation')

Plug('dstein64/nvim-scrollview')

Plug('rmagatti/auto-session') -- doesn't play nice with nvim-tree
--Plug('natecraddock/workspaces.nvim') -- maybe not needed with auto-session

-- mason-lspconfig page has instructions for tying these 3 plugins together.
-- https://github.com/williamboman/mason-lspconfig.nvim
-- also, a note from mason-lspconfig:
-- "this plugin uses the lspconfig server names in the APIs it exposes - 
-- not mason.nvim package names. See this table for a complete mapping."
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')

Plug('nvim-neotest/nvim-nio') -- nvim-dap-ui uses this
Plug('mfussenegger/nvim-dap') -- still need one adapter per language
Plug('jay-babu/mason-nvim-dap.nvim') -- allows automated installation of adapters

Plug('rcarriga/nvim-dap-ui')

vim.call('plug#end')

-- ==========
-- plugin configs
-- ==========

--require('plenary').setup()
--require('nvim-web-devicons').setup{}
--require('nui.nvim').setup{}

-- neo-tree
-- TODO: even if nvim saves a file after edit, neo-tree does not update git status
--require('neo-tree').setup{}

-- always open neotree
-- https://github.com/AstroNvim/AstroNvim/issues/344
--vim.api.nvim_create_autocmd("UiEnter",{
--    callback = function()
--        if vim.fn.argc() == 0 then
--            vim.cmd 'Neotree'
--        end
--    end
--})

-- seems that the only one of these which has anything mapped
-- is ctrl-k, which allows entering digraphs.
-- note that if tmux catches these, it needs to send the keys on to
-- neovim if neovim is active.
require('nvim-tmux-navigation').setup{
    disable_when_zoomed = true,
    keybindings = {
        left = '<C-h>',
        right = '<C-l>',
        up = '<C-k>',
        down = '<C-j>',
    }
}


-- nvim-tree configs.
-- run :NvimTreeHiTest to see example highlights.
-- example nvim lua setup:
-- https://gitee.com/kongjun18/nvim-tree.lua
-- Run |:NvimTreeHiTest| to show all the highlights 
-- that nvim-tree uses.
-- They can be customised before or after setup is called and 
-- will be immediately applied at runtime. e.g. >

-- note: loading the nvim-tree plugin closes the tree,
-- so every time we source our root config, the tree goes away.
-- to prevent this, check if nvim-tree is loaded before loading.
-- note! this means doing :so % will not reload tree settings.
-- we must :wqa and restart nvim for this plugin.
if (package.loaded['nvim-tree'] == nil) then
    require('nvim-tree').setup{
        git = { ignore = false }
    }
end


-- nvim-tree closes when sourcing lua config.
-- see if we can find a way to keep it open always.
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
-- edit: this breaks functionality with running "nvim ." in directory.
--local function open_nvim_tree()
--  -- check filetype to avoid the vim-plug "modifiable is off" bug.
--  -- https://github.com/junegunn/vim-plug/issues/1032
--    if vim.bo.filetype ~= 'vim-plug' then
--        require("nvim-tree.api").tree.open()
--    end
--end
--vim.api.nvim_create_autocmd({ "SourcePost" }, { callback = open_nvim_tree })
--:lua print(package.loaded['nvim-tree']) -- (returns table address?)
--:lua print(package.loaded['nvim-tree'] == nil) -- false
--:lua print(package.loaded['nvim-troo'] == nil) -- true
-- update: fixed! conditionally loading nvim-tree now.

require('lualine').setup()

-- which-key uses the global nvim timeout.
vim.o.timeout = true
vim.o.timeoutlen = 10
require('which-key').setup{ }

--require('neoscroll').setup{
--    respect_scrolloff = true,
--    cursor_scrolls_alone = true
--}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md
require('mini.animate').setup{
    -- really only want this for scrolling lines. disable some other defaults.
    cursor = { enable = false},
    open = { enable = false },
    close = { enable = false },
}

require('scrollview').setup{
    current_only = true
}
-- set scrollview bar color
-- :help scrollview
-- https://github.com/dstein64/nvim-scrollview/blob/main/doc/scrollview.txt
vim.cmd [[highlight Scrollview ctermbg=cyan]]

require('auto-session').setup{
    auto_save_enabled = true,
    auto_restore_enabled = true,
    --log_level = 'info',
    --pre_save_cmds = { 'Neotree close' },
    --post_save_cmds = {'Neotree show filesystem'},
    --post_restore_cmds = { 'Neotree show filesystem'},
    --post_restore_cmds = { 'Neotree'},
    pre_save_cmds = {'NvimTreeClose'},
    post_restore_cmds = {'NvimTreeOpen'},
}

--require('workspaces').setup{
--    auto_open = true
--}

-- https://github.com/williamboman/mason-lspconfig.nvim#setup
-- note, packages installable with mason-lspconfig (and their mason names)
-- are available at 
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require('mason').setup()
require('mason-lspconfig').setup{
  ensure_installed = {
    'lua_ls',
    'clangd',
    'bashls', -- requires npm, not sure about version.
    'pylsp', -- requires python3.12, will not work with 3.10.
    --'jedi_language_server',
    --'codelldb', -- not available from mason lspconfig.
  }
}

-- this is neovim/nvim-lspconfig, not williamboman/mason-lspconfig.nvim
-- instructions for how to use lspconfig along with mason and mason-lspconfig
-- are given here: https://github.com/williamboman/mason-lspconfig.nvim
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup{
  -- https://neovim.discourse.group/t/
  -- how-to-suppress-warning-undefined-global-vim/1882/3
  settings = { Lua = { diagnostics = { globals = {'vim'} } } }
}

lspconfig.clangd.setup{}

lspconfig.pylsp.setup{}


--require('nio').setup()
--require('nvim-dap').setup() -- doesn't exist, or not needed.
--require('nvim-dap-ui').setup() -- doesn't exist, or not needed.

-- make sure that adapters have been installed with Mason.
-- also, load default adapters.
-- names provided here must come from following list, not Mason UI
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
require("mason-nvim-dap").setup({
    ensure_installed = { 'codelldb', 'python' },

    -- load default adapters.
    handlers = {
        function(config)
            require('mason-nvim-dap').default_setup(config)
        end
    }
})

local dap = require('dap')
--dap.adapters.codelldb = {
--    stopOnEntry=false
--}

-- copied from:
-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
-- the following adapter is not needed if we invoke mason-nvim-dap defaults.
-- TODO: this config should really exist per-project...
--dap.adapters.codelldb = {
--  type = 'server',
--  port = "${port}",
--  executable = {
--    -- CHANGE THIS to your path!
--    command = '/home/fj/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
--    args = {"--port", "${port}"},
--
--    -- On windows you may have to uncomment this:
--    -- detached = false,
--  }
--}

--dap.defaults.fallback.exception_breakpoints = {'raised'}

-- TODO: this should live in the project directory, not global nvim config.
dap.configurations.c = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {}, -- hmm, can pass args to program here?
  },
}

local dapui = require('dapui')
dapui.setup()

--require('mason-nvim-dap').setup{
--    ensure_installed={'codelldb'},
--    handlers = {}
--}


-- youtube.com/watch?v=lsFoZIg-oDs The perfect Neovim setup for C++
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

-- dap keymaps
vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>',
    {desc='add breakpoint at line'})
vim.keymap.set('n', '<leader>dc', '<cmd> DapContinue <CR>',
    {desc='start or continue the debugger'})


-- nvim-lspconfig key remaps
-- copied from ___?

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float,
    {desc = 'vim diagnostic open float'})
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev,
    {desc = 'vim diagnostic goto prev'})
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next,
    {desc = 'vim diagnostic goto next'})
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist,
    {desc = 'vim diagnostic set loc list'})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.declaration,
        {buffer = ev.buf, desc = 'lsp declaration'})
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.definition,
        {buffer = ev.buf, desc = 'lsp definition'})
    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover,
        {buffer = ev.buf, desc = 'lsp hover'})
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation,
        {buffer = ev.buf, desc = 'lsp implementation'})

    -- conflicts with split ctrl-hkjl nav
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder,
        {buffer = ev.buf, desc = 'lsp workspace add'})
    vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder,
        {buffer = ev.buf, desc = 'lsp workspace remove'})
    vim.keymap.set('n', '<leader>lwl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        {buffer = ev.buf, desc = 'lsp workspace list'})
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition,
        {buffer = ev.buf, desc = 'lsp type definition'})
    vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename,
        {buffer = ev.buf, desc = 'lsp rename (buffer only?)'})
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action,
        {buffer = ev.buf, desc = 'lsp code action'})
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references,
        {buffer = ev.buf, desc = 'lsp references'})
    vim.keymap.set('n', '<leader>lm', function()
        vim.lsp.buf.format { async = true } end,
        {buffer = ev.buf, desc = 'lsp format'})
  end,
})

-- ==========
-- key remaps
-- ==========

-- keep this section last, so remaps can apply to plugins.
-- where possible, map key sequences (leader -> key)
-- rather than combinations (leader + key).
-- left ctrl and right ctrl are awkward to reach.

-- prefixes to reserve:
-- g: git
-- l: lsp functions
-- d: debugger
-- b: buffer
-- q: quickfix
-- s: split?
-- f: find files, string, regex?
-- r: replace?
-- f: fold? find? file explorer?
-- z: fold?
-- c: comments?
-- t: telescope?
-- (would be nice to have an in-vim command to run make.)

-- by default, leader is "\".

-- https://neovim.io/doc/user/lua-guide.html
-- Mappings can be created using vim.keymap.set().
-- This function takes three mandatory arguments:

-- Can we instead just use vim.cmd(":... ")?

-- add a shortcut to delete current buffer but leave pane open.
--vim.cmd(":map <leader>x :bp<bar>sp<bar>bn<bar>bd<CR>")
-- alternative (doesn't work with NvimTree open):
--vim.cmd(":map <leader>x :window b#<bar>bd#<CR>")
--vim.cmd(":command! Bd bp<bar>sp<bar>bn<bar>bd<CR>")
--vim.cmd(":map <leader>x :b#<bar>bd#<CR>")
-- better:
vim.keymap.set('n', '<leader>x', ':bp<bar>sp<bar>bn<bar>bd<CR>',
    {desc='close buffer but leave pane open'})
vim.keymap.set('n', '<leader>/', ':nohl<CR>',
    {desc='clear highlights for search'})

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

--try to set some muted colors for inactive windows
--note that vim has 'wincolor' and neovim has 'winhighlight'
--augroup('WinBackground', {clear = true})
--autocmd('WinEnter', { group = 'WinBackground', pattern = '*',
--    command = ':setl wincolor= syn=on' })
--autocmd('WinLeave', { group = 'WinBackground', pattern = '*',
--    command = ':setl wincolor=NormalNC syn=off' })

-- 2024-04-24
-- can't get nvim wrap option to propagate to NvimTree after startup.
-- but the autocommand below effectively does the same thing...

--vim.api.nvim_create_autocmd(
--    {
--        --"BufAdd", "BufNew", "BufRead", "BufFilePre", "BufFilePost",
--        --"BufEnter", "BufWinEnter", "BufLeave", "BufWinLeave"
--        "BufEnter", "BufLeave"
--        --"FileType"
--    },
--    {
--        --pattern={"NvimTree"},
--        command = "setlocal wrap",
--    }
--)


augroup('CursorLineActiveWin', {clear = true})
autocmd('WinEnter', {
    group = 'CursorLineActiveWin',
    pattern = '*',
    command = ':set cursorline'
})
autocmd('WinLeave', {
    group = 'CursorLineActiveWin',
    pattern = '*',
    command = ':set nocursorline'
})


-- ========
-- highlights
-- ========

-- (moved to conf/highlight.lua)

-- need a way to see what highlight is applied to give text...

-- also need a better way to browse highlight definitions than :hi
-- this thread suggests :Telescope highlights
-- https://www.reddit.com/r/neovim/comments/xdmenn/any_ergonomic_way_to_browse_highlight_groups/


-- function to examine the highlight group of text under cursor.
--vim.api.nvim_exec([[
--    function! SynGroup()
--        let l:s = synID(line('.'), col('.'), 1)
--        echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
--    endfun
--]], false)
--vim.cmd(":map <leader>h :call SynGroup()<CR>")

-- source highlights after all plugins so that highlight definitions apply.


--vim.cmd.normal('NvimTreeOpen')
--vim.cmd('NvimTreeOpen')
--nvim_tree_api.tree.open()
