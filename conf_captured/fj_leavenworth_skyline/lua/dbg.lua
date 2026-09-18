-- Toggle a trailing #dbg on the current line.
-- Mark those lines by highlighting the token with Todo (matchadd, once per window).
--
-- Change TOKEN when you reuse this in another language:
--   python / ruby / sh   #dbg
--   c / rust / js        //dbg
--   lua                  --dbg

local TOKEN = "#dbg"
local TOKEN_LEN = #TOKEN
local PATTERN = [[#dbg\s*$]]

--vim.api.nvim_set_hl(0, "DbgMark", { link = "Todo" })
vim.api.nvim_set_hl(0, "DbgMark", { link = "DiffDelete" })

local function rstrip(s)
  return (s:match("^(.-)%s*$")) or ""
end

local function toggle()
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
  local stripped = rstrip(line)

  local new
  if stripped:sub(-TOKEN_LEN) == TOKEN then
    new = rstrip(stripped:sub(1, #stripped - TOKEN_LEN))
  else
    new = stripped .. " " .. TOKEN
  end

  vim.api.nvim_buf_set_lines(buf, row - 1, row, false, { new })
end

local function ensure_match()
  for _, m in ipairs(vim.fn.getmatches()) do
    if m.group == "DbgMark" then
      return
    end
  end
  vim.fn.matchadd("DbgMark", PATTERN)
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("dbg_mark_hl", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "DbgMark", { link = "Todo" })
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("dbg_mark_win", { clear = true }),
  callback = ensure_match,
})

ensure_match()

vim.api.nvim_create_user_command("DbgToggle", toggle, {
  desc = "Toggle trailing #dbg on the current line",
})

vim.keymap.set("n", "<leader>b", toggle, {
  desc = "Toggle #dbg breakpoint (user)",
  silent = true,
})
