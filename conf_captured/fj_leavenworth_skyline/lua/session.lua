-- Save/restore a cwd session file. Native :mksession, no plugin manager.
-- require() this AFTER the cd-on-directory-arg autocmd in init.lua.

local SESSION = ".session"

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("session-save", { clear = true }),
  callback = function()
    vim.cmd("mksession! " .. SESSION)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("session-restore", { clear = true }),
  nested = true,
  callback = function()
    if vim.v.this_session ~= "" then
      return
    end
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 0 then
      return
    end
    if vim.fn.argc() > 1 then
      return
    end
    if vim.fn.filereadable(SESSION) == 1 then
      vim.cmd("source " .. vim.fn.fnameescape(SESSION))
    end
  end,
})
