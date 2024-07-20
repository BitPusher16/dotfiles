-- ========
-- autocommands
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

