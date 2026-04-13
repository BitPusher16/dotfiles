vim.opt.scrolloff = 1000
vim.opt.number = true
vim.opt.mouse = ""

--vim.g.mapleader = "\\"
vim.g.mapleader = ";"
vim.o.timeout = false -- disable timeout for mappings.

vim.opt.termguicolors = false
--vim.o.t_Co = 16

--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "none" })

-- enabling the following line helps to show that alacritty
-- uses a background color which is not one of the 16 ansi colors.
--vim.api.nvim_set_hl(0, "Normal", { ctermbg = 0 })


-- getting copy-paste to work on neovim is a deep rabbit hole.
-- it gets worse when a terminal emulator (alacritty) and session manager (tmux) are involved.
-- the easiest setup i have found is one-way copy paste.
-- set neovim to copy to the system clipboard. yanked lines will be available in system clipboard.
-- to paste from system clipboard, use system (or emulator) paste with ctrl-v.
vim.opt.clipboard = 'unnamedplus'

vim.opt.ignorecase = true -- search case insensitive.
vim.opt.smartcase = true -- if search includes an uppercase, search case sensitive.

--vim.opt.statusline = "%f %m %r%=%l/%L %p%%"   -- filename + modified + ruler
vim.api.nvim_set_hl(0, "StatusLine",   { link = "Comment" }) -- use comment styling for status line.
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "Comment" }) -- status line non-current (non-active).

--vim.opt.cursorline = true
--vim.api.nvim_set_hl(0, 'CursorLine', { ctermbg = 8 }) --8 is black
--vim.api.nvim_set_hl(0, 'CursorLineNr', { ctermbg = 13 }) --8 is black

-- remap "change" command to "change and copy to null buffer".
-- this preserves text that has been copied to clipboard for pasting.
-- update: don't need this. you can directly overwrite selected text with either p or terminal paste.
--vim.keymap.set({'n', 'x'}, 'C', '"_C')

vim.o.expandtab = true -- convert tabs to spaces on file open? what about makefiles?
--vim.o.softtabstop = 4  -- spaces inserted on tab press.
vim.o.shiftwidth = 4   -- on tab press or backspace, insert or delete enough spaces to move to next multiple of shiftwidth.

-- cause help windows to appear almost maximized?
--vim.api.nvim_create_autocmd(
--    "BufEnter", { callback = function() if vim.bo.buftype == "help" then vim.cmd("wincmd _") end end, }
--    --"BufEnter", { callback = function() if vim.bo.buftype == "help" then vim.cmd("wincmd o") end end, }
--)

--vim.api.nvim_create_autocmd('BufWinEnter', {
--    pattern = '*',
--    callback = function(event)
--        if vim.bo[event.buf].filetype == 'help' then
--            vim.cmd.only()
--        end
--    end,
--})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    -- the second check here avoids the "already only one window error
    -- by checking if more than one window exists.
    -- vim.fn.winnr("$") returns number of windows in current tab.
    if vim.bo.buftype == "help" and vim.fn.winnr("$") > 1 then
      vim.cmd("wincmd T")
    end
  end,
})

-- neovim sets pwd (and therefore netrw default dir) to the directory you start neovim from,
-- not the directory argument you pass at the command line. change this.
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Set working directory to the directory passed as a command-line argument (e.g. `nvim ~/.config/nvim`)",
  group = vim.api.nvim_create_augroup("cd-on-directory-arg", { clear = true }),
  callback = function()
    -- Only act if exactly one argument was passed and it is a directory
    if vim.fn.argc() == 1 then
      local arg = vim.fn.argv(0)
      if arg and vim.fn.isdirectory(arg) == 1 then
        -- Use absolute path to avoid any symlink/relative-path issues
        vim.api.nvim_set_current_dir(vim.fn.fnamemodify(arg, ":p"))
      end
    end
  end,
})

-- autosave all edits.
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified
      and vim.bo.buftype == ""
      and vim.fn.expand("%") ~= ""
      and not vim.bo.readonly
    then
      vim.cmd("silent! update")

      -- update does not notify LSP. notify here.
      local buf = vim.api.nvim_get_current_buf()
      local filename = vim.api.nvim_buf_get_name(buf)
      for _, client in pairs(vim.lsp.get_clients({ bufnr = buf })) do
        client.notify("textDocument/didSave", {
          textDocument = { uri = vim.uri_from_fname(filename) },
        })
      end

    end
  end,
})

-- esc in normal mode does nothing.
-- use it to clear the / search.
vim.keymap.set("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
  end
  return "<Esc>"
end, { expr = true, silent = true })

vim.cmd('packadd! termdebug')

-- termdebug hotkeys (not validated yet)
--vim.keymap.set('n', '<F5>', ':Break<CR>', { desc = 'Set breakpoint at cursor' })
--vim.keymap.set('n', '<F6>', ':Clear<CR>', { desc = 'Clear breakpoint at cursor' })
--vim.keymap.set('n', '<F9>', ':Step<CR>', { desc = 'Step into' })
--vim.keymap.set('n', '<F10>', ':Over<CR>', { desc = 'Step over' })
--vim.keymap.set('n', '<F11>', ':Finish<CR>', { desc = 'Step out of function' })
--vim.keymap.set('n', '<F12>', ':Continue<CR>', { desc = 'Continue to next breakpoint' })
----vim.keymap.set('n', '<leader>e', ':Evaluate<CR>', { desc = 'Evaluate expression under cursor' })
--vim.keymap.set('n', '<F7>', ':Evaluate<CR>', { desc = 'Evaluate expression under cursor' })

vim.g.netrw_liststyle = 3 -- set netrw to tree view.
vim.g.netrw_list_hide = '' -- don't hide any files in netrw.
vim.g.netrw_banner = 0 -- hide the default banner.

require("netrw_help")

require("bookmarks")

vim.o.winborder = "rounded" -- this makes lsp popups stand out more.
vim.o.signcolumn = "yes" -- leave sign column on always, otherwise lsp causes jitter.
require("language_server")

require("leader_help")
