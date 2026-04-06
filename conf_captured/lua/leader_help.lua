
---- Put this anywhere in your init.lua after you set mapleader
--local function show_leader_maps()
--  local leader = vim.g.mapleader or " "
--  local maps = vim.api.nvim_get_keymap("n")   -- normal mode; add "v", "x", etc. if you want
--
--  local leader_maps = {}
--  for _, map in ipairs(maps) do
--    if map.lhs:find("^" .. vim.pesc(leader)) then
--      table.insert(leader_maps, {
--        lhs = map.lhs,
--        rhs = map.rhs or (map.callback and "<lua callback>" or ""),
--        desc = map.desc or "",
--      })
--    end
--  end
--
--  -- sort by lhs for nicer display
--  table.sort(leader_maps, function(a, b) return a.lhs < b.lhs end)
--
--  -- build display lines
--  local lines = { "=== Leader Keymaps ===", "" }
--  for _, m in ipairs(leader_maps) do
--    table.insert(lines, string.format("%-12s → %s", m.lhs, m.desc ~= "" and m.desc or m.rhs))
--  end
--
--  -- create floating window
--  local buf = vim.api.nvim_create_buf(false, true)
--  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
--  vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf }) -- nice syntax if you want
--
--  local width = 60
--  local height = #lines
--  local win = vim.api.nvim_open_win(buf, true, {
--    relative = "editor",
--    width = width,
--    height = height,
--    col = math.floor((vim.o.columns - width) / 2),
--    row = math.floor((vim.o.lines - height) / 2),
--    style = "minimal",
--    border = "rounded",
--    title = " Leader Keymaps ",
--    title_pos = "center",
--  })
--
--  -- close with q, esc, or <CR>
--  vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, nowait = true })
--  vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = buf, nowait = true })
--  vim.keymap.set("n", "<CR>", "<cmd>close<CR>", { buffer = buf, nowait = true })
--end
--
---- Bind it to <leader>?
--vim.keymap.set("n", "<leader>?", show_leader_maps, { desc = "Show all leader keymaps" })

local function show_leader_maps()
  local leader = vim.g.mapleader or " "
  local maps = vim.api.nvim_get_keymap("n")

  local leader_maps = {}
  for _, map in ipairs(maps) do
    if map.lhs:find("^" .. vim.pesc(leader)) then
      table.insert(leader_maps, {
        lhs  = map.lhs,
        rhs  = map.rhs or (map.callback and "<lua callback>" or ""),
        desc = map.desc or "",
      })
    end
  end

  table.sort(leader_maps, function(a, b) return a.lhs < b.lhs end)

  local lines = {
    "Leader Keymaps                                          (q to close)",
    "",
  }
  for _, m in ipairs(leader_maps) do
    table.insert(lines, string.format(" %-14s  %s", m.lhs, m.desc ~= "" and m.desc or m.rhs))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype    = "nofile"
  vim.bo[buf].filetype   = "help"
  vim.bo[buf].buflisted  = false

  local win = vim.api.nvim_open_win(buf, true, {
    relative  = "editor",
    width     = vim.o.columns,
    height    = vim.o.lines,
    col       = 0,
    row       = 0,
    style     = "minimal",
    border    = "none",
    title     = " Leader Keymaps ",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
    vim.schedule(function()
        vim.cmd("redraw!")
    end)
  end, {
    buffer  = buf,
    silent  = true,
    nowait  = true,
    desc    = "Close leader keymaps window",
  })
end

vim.keymap.set("n", "<leader>?", show_leader_maps, { desc = "Show all leader keymaps" })





local function show_user_maps()
  local maps = vim.api.nvim_get_keymap("n")

  local user_maps = {}
  for _, map in ipairs(maps) do
    if map.desc and map.desc:find("(user)", 1, true) then
      table.insert(user_maps, {
        lhs  = map.lhs,
        rhs  = map.rhs or (map.callback and "<lua callback>" or ""),
        desc = map.desc,
      })
    end
  end

  table.sort(user_maps, function(a, b) return a.lhs < b.lhs end)

  local lines = {
    "User Keymaps                                            (q to close)",
    "",
  }
  for _, m in ipairs(user_maps) do
    table.insert(lines, string.format(" %-14s  %s", m.lhs, m.desc))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype    = "nofile"
  vim.bo[buf].filetype   = "help"
  vim.bo[buf].buflisted  = false

  local win = vim.api.nvim_open_win(buf, true, {
    relative  = "editor",
    width     = vim.o.columns,
    height    = vim.o.lines,
    col       = 0,
    row       = 0,
    style     = "minimal",
    border    = "none",
    title     = " User Keymaps ",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
    vim.schedule(function()
        vim.cmd("redraw!")
    end)
  end, {
    buffer  = buf,
    silent  = true,
    nowait  = true,
    desc    = "Close user keymaps window",
  })
end

vim.keymap.set("n", "<leader>,", show_user_maps, { desc = "Show all user keymaps" })
