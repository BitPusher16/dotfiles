-- Minimal indentation-based block navigation (zero plugins)
-- UPDATED: now completely skips empty/blank lines when searching
--   • Only considers non-blank lines as candidates
--   • "Following line" = next non-blank line after the candidate
--   • <C-.> jumps down, <C-,> jumps up — exactly as you described

local function is_blank(lnum)
  return vim.fn.getline(lnum):match('^%s*$') ~= nil
end

local function get_indent(lnum)
  return vim.fn.indent(lnum)
end

local function get_next_nonblank(start)
  local last = vim.fn.line('$')
  for i = start, last do
    if not is_blank(i) then
      return i
    end
  end
  return nil
end

local function get_prev_nonblank(start)
  for i = start, 1, -1 do
    if not is_blank(i) then
      return i
    end
  end
  return nil
end

local function next_block_start()
  local cur = vim.fn.line('.')
  local candidate = get_next_nonblank(cur + 1)

  while candidate do
    local next_line = get_next_nonblank(candidate + 1)
    if next_line and get_indent(next_line) > get_indent(candidate) then
      vim.api.nvim_win_set_cursor(0, { candidate, 0 })
      vim.cmd('normal! ^')   -- land on first non-blank char
      return
    end
    candidate = get_next_nonblank(candidate + 1)
  end
  -- no more blocks → do nothing
end

local function prev_block_start()
  local cur = vim.fn.line('.')
  local candidate = get_prev_nonblank(cur - 1)

  while candidate do
    local next_line = get_next_nonblank(candidate + 1)
    if next_line and get_indent(next_line) > get_indent(candidate) then
      vim.api.nvim_win_set_cursor(0, { candidate, 0 })
      vim.cmd('normal! ^')
      return
    end
    candidate = get_prev_nonblank(candidate - 1)
  end
  -- no more blocks → do nothing
end

vim.keymap.set('n', '<A-,>', next_block_start, { desc = 'Next block start (skip blanks)' })
vim.keymap.set('n', '<A-.>', prev_block_start, { desc = 'Previous block start (skip blanks)' })
