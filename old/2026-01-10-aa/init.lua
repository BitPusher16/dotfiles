vim.opt.scrolloff = 1000
vim.opt.number = true
vim.opt.mouse = ""

vim.opt.termguicolors = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { ctermbg = 13 })

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
