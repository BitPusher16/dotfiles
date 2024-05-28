--vim.cmd[[ nnoremap <silent> <C-l> <Cmd>NvimTmuxNavigateRight<CR> ]]
--vim.cmd[[ nnoremap <silent> <C-j> <Cmd>NvimTmuxNavigateDown<CR> ]]
--vim.cmd[[ nnoremap <silent> <C-k> <Cmd>NvimTmuxNavigateUp<CR> ]]
--vim.cmd[[ nnoremap <silent> <C-l> <Cmd>NvimTmuxNavigateRight<CR> ]]

local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)


vim.keymap.set('n', '<leader>x', ':bp<bar>sp<bar>bn<bar>bd<CR>',
    {desc='close buffer but leave pane open'})
vim.keymap.set('n', '<leader>/', ':nohl<CR>',
    {desc='clear highlights for search'})
