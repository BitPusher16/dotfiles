
--package.path = package.path .. ';/home/fj/src/dotfiles/nvim/?.lua'
--require('init')

--package path has already been augmented in the home dir init.lua config.
require('other')

vim.wo.number = true
--vim.wo.relativenumber = true

-- allow copy and paste with system clipboard.
vim.opt.clipboard = 'unnamedplus'

-- choosing spaces rather than tabs bc it means my code will
-- display with consistent formatting when pushed to github, etc.
-- note: somehow nvim knows to ignore these settings for makefiles.
-- where is this configured?
vim.opt.tabstop = 4 -- 4 spaces for tabs.
vim.opt.shiftwidth = 4 -- 4 spaces for indent width.
vim.opt.expandtab = true -- expand tab to spaces.
vim.opt.autoindent = true -- copy indent from current line to new one.

-- nvim-tree recommends these https://github.com/nvim-tree/nvim-tree.lua:
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- edgy plugin recommends these settings https://github.com/folke/edgy.nvim:
vim.opt.laststatus = 3
vim.opt.splitkeep = 'screen'

-- which is newer, the syntax below, or vim.keymap.set()?
--vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true})

--vim.cmd(":nnoremap <C-H> <C-W>h")

-- these mappings suggested by terminal-emulator help:
vim.cmd(':tnoremap <C-h> <C-\\><C-N><C-w>h')
vim.cmd(':tnoremap <C-j> <C-\\><C-N><C-w>j')
vim.cmd(':tnoremap <C-k> <C-\\><C-N><C-w>k')
vim.cmd(':tnoremap <C-l> <C-\\><C-N><C-w>l')
vim.cmd(':inoremap <C-h> <C-\\><C-N><C-w>h')
vim.cmd(':inoremap <C-j> <C-\\><C-N><C-w>j')
vim.cmd(':inoremap <C-k> <C-\\><C-N><C-w>k')
vim.cmd(':inoremap <C-l> <C-\\><C-N><C-w>l')
vim.cmd(':nnoremap <C-h> <C-w>h')
vim.cmd(':nnoremap <C-j> <C-w>j')
vim.cmd(':nnoremap <C-k> <C-w>k')
vim.cmd(':nnoremap <C-l> <C-w>l')

-- https://www.reddit.com/r/neovim/comments/akcp97/how_to_automatically_enter_insert_mode_on_opening/

-- pckr plugin bootstrap from
-- https://github.com/lewis6991/pckr.nvim
local function bootstrap_pckr()
    local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

    if not vim.uv.fs_stat(pckr_path) then
    vim.fn.system({
        'git',
        'clone',
        "--filter=blob:none",
        'https://github.com/lewis6991/pckr.nvim',
        pckr_path
    })
    end

    vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
    -- My plugins here
    -- 'foo1/bar1.nvim';
    -- 'foo2/bar2.nvim';
    {
        'rmagatti/auto-session',
        requires = {'nvim-tree/nvim-tree.lua'},
        config = function()
            require('auto-session').setup{ 
                pre_save_cmds = {'NvimTreeClose'},
                post_restore_cmds = {'NvimTreeOpen'},
            }
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup{}
        end
  
    },
    {
        'folke/edgy.nvim',
        config = function()
            require('edgy').setup{}
        end
    },
}


