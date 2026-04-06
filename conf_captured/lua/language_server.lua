
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
--vim.api.nvim_create_user_command("LspHover",   function() vim.lsp.buf.hover()          end, {})
--vim.api.nvim_create_user_command("LspDef",     function() vim.lsp.buf.definition()      end, {})
--vim.api.nvim_create_user_command("LspRefs",    function() vim.lsp.buf.references()      end, {})
--vim.api.nvim_create_user_command("LspDiag",    function() vim.diagnostic.open_float()   end, {})
--vim.api.nvim_create_user_command("LspPrev",    function() vim.diagnostic.goto_prev()    end, {})
--vim.api.nvim_create_user_command("LspNext",    function() vim.diagnostic.goto_next()    end, {})

-- Global ;l<key> mappings (moved out of the autocmd — always active)
-- (works because you set semicolon as your leader)

--local map = function(key, func, desc)
--  vim.keymap.set("n", "<leader>l" .. key, func, { desc = "LSP: " .. desc })
--end

local lsp_map = function(key, func, desc)
  vim.keymap.set("n", "gr" .. key, func, { desc = "LSP: " .. desc })
end

-- these lsp actions are mapped by default in nvim:
-- grr       references
-- gra       code_action ??
-- grn       rename
-- gri       implementation
-- grt       type_definition
-- i_CTRL-S  signature help (in insert mode)

-- these are unused in nvim by default:
-- grb
-- grc
-- grd
-- gre (but this is short for grep)
-- grf
-- grg
-- grh
-- grj
-- grk
-- ... (remainder not checked)
-- grp
-- grs

lsp_map("h", vim.lsp.buf.hover,          "(user) Hover")
lsp_map("d", vim.lsp.buf.definition,     "(user) Go to Definition (use -> def)")
lsp_map("f", vim.lsp.buf.references,     "(user) Find References (def -> uses)")
lsp_map("s", vim.diagnostic.open_float,  "(user) Show E/W/H message")
lsp_map("k", vim.diagnostic.goto_prev,   "(user) Previous diagnostic")
lsp_map("j", vim.diagnostic.goto_next,   "(user) Next diagnostic")
