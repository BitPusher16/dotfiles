-- ==========
-- key remaps
-- ==========

-- keep this section last, so remaps can apply to plugins.
-- where possible, map key sequences (leader -> key)
-- rather than combinations (leader + key).
-- left ctrl and right ctrl are awkward to reach.

-- as much as possible, follow this convention:
-- alt: operating system navigation (e.g. alt+tab)
-- super: operating system navigation
-- ctrl: tmux, and some built-in nvim functionality
-- leader '/' : user-defined convenience functions
-- space: ??

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
--vim.keymap.set('n', '<leader>/', ':nohl<CR>',
--    {desc='clear highlights for search'})

-- note: :nohl doesn't clear neo scroll search results.
-- must call scroll view refresh.
vim.keymap.set('n', '?', ':nohl<CR>:ScrollViewRefresh<CR>',
    {desc='clear highlights for search'})

-- unmap some unuseful ctrl key combinations for use later.
--vim.cmd(":unmap <C-c>") -- does same thing as esc
--vim.cmd(":unmap <C-f>") -- prints file name and status, also available with :f

--vim.cmd(":nnoremap <C-H> <C-W>h")
--vim.cmd(":nnoremap <C-J> <C-W>j")
--vim.cmd(":nnoremap <C-K> <C-W>k")
--vim.cmd(":nnoremap <C-L> <C-W>l")

local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)

-- leap motions
vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward)')

-- replace default search "/" with a search that doesn't immediately jump.
-- note: space is important. if space is included after (tranquille_search),
-- the search command will start with a space.
vim.cmd[[ nmap <unique> / <Plug>(tranquille_search)]]

--vim.cmd[[ nmap <unique> / <Plug>(tranquille_search_down)]]
--vim.cmd[[ nmap <unique> ? <Plug>(tranquille_search_up)]]
