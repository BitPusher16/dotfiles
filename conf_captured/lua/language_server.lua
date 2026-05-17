-- on opening certain filetypes,
-- look in the current dir for a start-lsp.sh file.
-- run it if found.
vim.api.nvim_create_autocmd("FileType", {

  -- this line needed so neovim doesn't launch start-lsp on all file types.
  pattern = { "rust", "python", "sh" },

  callback = function()
    -- walks up the directory tree looking for start-lsp.sh, starting at 0 (current buffer).
    local root = vim.fs.root(0, "start-lsp.sh")

    if not root then
      return
    end

    local script = root .. "/start-lsp.sh"

    -- check if lsp script is executable.
    if vim.fn.executable(script) == 1 then
      vim.lsp.start({
        name = vim.bo.filetype .. "-lsp",
        cmd = { script, vim.bo.filetype },
        root_dir = root,
      })
    end
  end,
})


--  what does this do?
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }

-- Enable LSP auto-completion on trigger characters (like ".")
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,  -- This is what makes it pop on "." automatically
      })
    end
  end,
})

-- p menu border available in nvim 12.
--vim.opt.pumborder = 'single' -- or rounded, double, solid, shadow.

-- https://neovim.io/doc/user/syntax/#cterm-colors
-- (use NR-16 values below.)
--
--          NR-16   NR-8    COLOR NAME 
--	    0	    0	    Black
--	    1	    4	    DarkBlue
--	    2	    2	    DarkGreen
--	    3	    6	    DarkCyan
--	    4	    1	    DarkRed
--	    5	    5	    DarkMagenta
--	    6	    3	    Brown, DarkYellow
--	    7	    7	    LightGray, LightGrey, Gray, Grey
--	    8	    0*	    DarkGray, DarkGrey
--	    9	    4*	    Blue, LightBlue
--	    10	    2*	    Green, LightGreen
--	    11	    6*	    Cyan, LightCyan
--	    12	    1*	    Red, LightRed
--	    13	    5*	    Magenta, LightMagenta
--	    14	    3*	    Yellow, LightYellow
--	    15	    7*	    White
--vim.api.nvim_set_hl(0, 'Pmenu', {
    --ctermfg = 10, -- 10 = green?
    --ctermbg = 0, -- 0 = black?
    --ctermfg = 4,
    --ctermbg = 16,
    --fg = "Green",
    --bg = "Grey",
--})
--vim.api.nvim_set_hl(0, "Pmenu", {link="Normal"})

-- this is better. don't do custom color picking.
-- link to existing highlight settings,
-- preferably ones that ship with neovim.
vim.api.nvim_set_hl(0, "Pmenu", {link="DiffAdd"})


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
-- gre (not explicitly used, but gre is short for grep.)
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


-- Updated for string-based SymbolKind (what your rust-analyzer actually returns)
local function lsp_document_symbols(filter)
  local kind_map = {
    -- Single categories
    f   = {"Method", "Function"},        -- Methods + Functions
    fn  = {"Function"},                  -- Functions only
    m   = {"Method"},                    -- Methods only
    s   = {"Struct"},                    -- Structs only
    e   = {"Enum"},                      -- Enums only
    t   = {"Interface"},                 -- Traits (rust-analyzer calls them Interface)
    c   = {"Constant"},                  -- Constants only

    -- Combinations
    fs  = {"Method", "Function", "Struct"},      -- ← your perfect starting point
    fst = {"Method", "Function", "Struct", "Interface", "Enum"},
    all = nil,                                   -- everything (like gO)
  }

  local wanted = kind_map[filter] or kind_map.fs   -- default = fs

  vim.lsp.buf.document_symbol({
    on_list = function(opts)
      local items = opts.items

      if wanted then
        items = vim.tbl_filter(function(item)
          return vim.tbl_contains(wanted, item.kind)
        end, items)
      end

      if #items == 0 then
        vim.notify("No matching symbols found", vim.log.levels.WARN)
        return
      end

      opts.items = items
      vim.fn.setqflist(items)
      vim.cmd.copen()          -- change to vim.cmd.lopen() if you prefer location list
    end,
  })
end


-- Add this anywhere after your lsp_document_symbols() function is defined
vim.keymap.set('n', 'g[', function()
  lsp_document_symbols('fs')
end, { desc = 'LSP (user): View functions, methods, structs in quickfix list' })

