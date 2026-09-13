local function show_cheatsheet()
  local lines = {
    "MY NEOVIM CHEAT SHEET",
    "",
    " Leader is ;",
    "   ;x           write and quit  (same as :wq)",
    "   ;?           this cheat sheet",
    "",
    " General",
    "   <Esc>        clear search highlight",
    "",
  }

  vim.cmd("split")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].buflisted = false
  vim.bo[buf].buftype = "help"
  vim.bo[buf].modifiable = false
  vim.bo[buf].modified = false
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "help"
end

vim.keymap.set("n", "<leader>?", show_cheatsheet, {
  desc = "Show cheat sheet (user)",
})
