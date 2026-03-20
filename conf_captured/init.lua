vim.opt.scrolloff = 1000
vim.opt.number = true
vim.opt.mouse = ""

--vim.g.mapleader = "\\"

vim.g.netrw_liststyle = 3 	-- Set Netrw to tree view (style 3)
--vim.g.netrw_browse_split = 4 	-- Keep the tree expanded when navigating back (optional, but helpful)
--vim.g.netrw_browse_split = 2 	-- ??
--vim.g.netrw_winsize = 16 	-- Set netrw to behave more like a file browser
--vim.g.netrw_banner = 0 		-- Hide banner
--vim.g.netrw_altv = 1

vim.opt.termguicolors = false
vim.opt.clipboard = 'unnamedplus'

vim.opt.ignorecase = true
vim.opt.smartcase = true

--vim.opt.cursorline = true
--vim.api.nvim_set_hl(0, 'CursorLine', { ctermbg = 8 }) --8 is black
--vim.api.nvim_set_hl(0, 'CursorLineNr', { ctermbg = 13 }) --8 is black

-- remap "change" command to "change and copy to null buffer".
-- this allows pasting of whatever was previously copied to clipboard.
vim.keymap.set({'n', 'x'}, 'C', '"_C')

vim.o.expandtab = true -- convert tabs to spaces on file open? what about makefiles?
--vim.o.softtabstop = 4  -- spaces inserted on tab press.
vim.o.shiftwidth = 4   -- on tab press or backspace, insert or delete enough spaces to move to next multiple of shiftwidth.



vim.cmd('packadd! termdebug')

vim.api.nvim_create_autocmd(
	"BufEnter", { callback = function() if vim.bo.buftype == "help" then vim.cmd("wincmd _") end end, })
	--"BufEnter", { callback = function() if vim.bo.buftype == "help" then vim.cmd("wincmd o") end end, })

-- termdebug hotkeys (not validated yet)
vim.keymap.set('n', '<F5>', ':Break<CR>', { desc = 'Set breakpoint at cursor' })
vim.keymap.set('n', '<F6>', ':Clear<CR>', { desc = 'Clear breakpoint at cursor' })
vim.keymap.set('n', '<F9>', ':Step<CR>', { desc = 'Step into' })
vim.keymap.set('n', '<F10>', ':Over<CR>', { desc = 'Step over' })
vim.keymap.set('n', '<F11>', ':Finish<CR>', { desc = 'Step out of function' })
vim.keymap.set('n', '<F12>', ':Continue<CR>', { desc = 'Continue to next breakpoint' })
vim.keymap.set('n', '<leader>e', ':Evaluate<CR>', { desc = 'Evaluate expression under cursor' })



vim.g.netrw_list_hide = ''
require("netrw_help")

require("bookmarks")
