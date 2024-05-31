-- ========
-- vim opt
-- ========

vim.opt.number = true
vim.opt.relativenumber = true
--vim.cmd( ":hi ColorColumn ctermbg=cyan" )
--vim.cmd( ":hi ColorColumn ctermbg=lightgray" )
vim.cmd( ":hi ColorColumn ctermbg=black" )

-- keep cursor centered if possible
vim.opt.scrolloff = 999
--vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"

--vim.opt.colorcolumn = "81"
-- look for a more aesthetic way to mark long lines
--vim.cmd [[ :match LongLine /\%>80c/ ]]
vim.cmd [[ :match Error /\%>80c/ ]]

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

