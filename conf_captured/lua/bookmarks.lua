-- ==================== HELP BOOKMARKS ====================
local help_bookmarks = {
  "netrw-quickmaps",  -- netrw-quickmaps
  "options",          -- options
  "quickref",         -- quick reference card
  "usr_01",           -- user manual chapter 1
  "usr_02",           -- user manual chapter 2
  "lsp",              -- LSP config
  "treesitter",       -- Treesitter
  "mapping",          -- key mappings
  "autocmd",          -- autocmds
  -- add/remove as many as you want ↓
}

vim.api.nvim_create_user_command("HelpBookmarks", function()
  vim.ui.select(
    help_bookmarks,
    {
      prompt = "Select help bookmark:",
      format_item = function(item)
        return string.format("%-20s → :help %s", item, item)
      end,
    },
    function(choice)
      if choice then
        vim.cmd("help " .. choice)
      end
    end
  )
end, {
  desc = "Open your bookmarked Neovim help pages",
})

vim.keymap.set("n", "<leader>hb", ":HelpBookmarks<CR>", {
--vim.keymap.set("n", "<leader>b", ":HelpBookmarks<CR>", {
  desc = "Help bookmarks",
  silent = true,
})
