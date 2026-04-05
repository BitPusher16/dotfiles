local function show_netrw_help()
  local help_text = {
    "Netrw Quick Help                              (q to close, q F1 for normal help)",
    "",
    " Navigation",
    "   <CR> / l     Open file or directory",
    "   -            Go to parent directory",
    "   u / U        Back / Forward in history",
    "   p            Preview file",
    "   o            Horizontal split",
    "   v            Vertical split",
    "   t            Open in new tab",
    "   <C-l>        Refresh listing",
    "",
    " File Operations",
    "   %            Create new file",
    "   d            Create new directory",
    "   R            Rename",
    "   D            Delete",
    "   x            Open with external program",
    "",
    " Marking & Bulk Actions",
    "   mf           Mark / unmark file",
    "   mr           Mark files by regex",
    "   mt           Set target directory",
    "   mc           Copy marked files",
    "   mm           Move marked files",
    "   mu           Unmark all",
    "",
    " Display & Sorting",
    "   i            Cycle view style (thin/long/tree)",
    "   s            Cycle sort method",
    "   r            Reverse sort order",
    "   gh           Toggle hidden (dot) files",
    "   a            Cycle hide/show mode",
    "",
    " Other",
    "   qb           Show bookmarks + history",
    "   qf           Show file info",
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, help_text)

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype   = "nofile"
  vim.bo[buf].filetype  = "help"
  vim.bo[buf].buflisted = false

  -- Full-pane floating window (covers the entire editor)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width     = vim.o.columns,
    height    = vim.o.lines,
    col       = 0,
    row       = 0,
    style     = "minimal",
    --border    = "rounded",          -- change to "none" for zero borders
    border    = "none",          -- change to "none" for zero borders
    title     = " Netrw Quick Help ",
    title_pos = "center",
  })

  -- ONLY 'q' — strictly local to this help buffer (no global pollution)
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, {
    buffer = buf,
    silent = true,
    nowait = true,
    desc   = "Close netrw help window",
  })
end

-- Override ? in netrw
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "?", show_netrw_help, {
      buffer = true,
      silent = true,
      desc   = "Show custom netrw help (full-pane floating)",
    })
  end,
})
