
-- General per-project LSP starter (no plugins)
vim.api.nvim_create_autocmd("FileType", {

  -- this line needed so neovim doesn't launch start-lsp on all file types.
  pattern = { "rust", "python", "sh" },   -- ← add any other languages here

  callback = function()
    -- The presence of start-lsp.sh *defines* the project root
    local root = vim.fs.root(0, "start-lsp.sh")
    if not root then
      return
    end

    local script = root .. "/start-lsp.sh"

    if vim.fn.executable(script) == 1 then
      vim.lsp.start({
        name = vim.bo.filetype .. "-lsp",
        cmd = { script },
        root_dir = root,
      })
    end
  end,
})



-- Global user commands (you liked these — :LspHover, :LspDiag, etc.)
vim.api.nvim_create_user_command("LspHover",   function() vim.lsp.buf.hover()          end, {})
vim.api.nvim_create_user_command("LspDef",     function() vim.lsp.buf.definition()      end, {})
vim.api.nvim_create_user_command("LspRefs",    function() vim.lsp.buf.references()      end, {})
vim.api.nvim_create_user_command("LspDiag",    function() vim.diagnostic.open_float()   end, {})
vim.api.nvim_create_user_command("LspPrev",    function() vim.diagnostic.goto_prev()    end, {})
vim.api.nvim_create_user_command("LspNext",    function() vim.diagnostic.goto_next()    end, {})

-- Global ;l<key> mappings (moved out of the autocmd — always active)
-- (works because you set semicolon as your leader)
local map = function(key, func, desc)
  vim.keymap.set("n", "<leader>l" .. key, func, { desc = "LSP: " .. desc })
end

map("h", vim.lsp.buf.hover,          "Hover")
map("d", vim.lsp.buf.definition,     "Go to Definition (use → def)")
map("r", vim.lsp.buf.references,     "Find References (def → uses)")
map("s", vim.diagnostic.open_float,  "Show E/W/H message")
map("p", vim.diagnostic.goto_prev,   "Previous diagnostic")
map("n", vim.diagnostic.goto_next,   "Next diagnostic")
