-- ;r  quickfix list of project files, newest mtime first.
-- Edit SUFFIXES / SKIP_DIRS. This replaces the current quickfix list.

local SUFFIXES = {
  [".py"] = true,
  [".lua"] = true,
  [".c"] = true,
  [".h"] = true,
  [".rs"] = true,
  [".js"] = true,
  [".ts"] = true,
  [".sh"] = true,
}

local SKIP_DIRS = {
  [".git"] = true,
  [".venv"] = true,
  ["__pycache__"] = true,
  ["node_modules"] = true,
  ["target"] = true,
  ["build"] = true,
}

local function collect(dir, acc)
  for name, kind in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)
    if kind == "directory" then
      if not SKIP_DIRS[name] then
        collect(path, acc)
      end
    elseif kind == "file" then
      local ext = name:match("%.[^.]+$")
      if ext and SUFFIXES[ext] then
        local stat = vim.uv.fs_stat(path)
        if stat then
          acc[#acc + 1] = { path = path, mtime = stat.mtime.sec }
        end
      end
    end
  end
end

local function show()
  local files = {}
  collect(vim.fn.getcwd(), files)
  table.sort(files, function(a, b)
    return a.mtime > b.mtime
  end)

  local items = {}
  for _, f in ipairs(files) do
    items[#items + 1] = {
      filename = vim.fn.fnamemodify(f.path, ":."),
      lnum = 1,
      text = os.date("%Y-%m-%d %H:%M", f.mtime),
    }
  end

  vim.fn.setqflist({}, " ", { title = "recent files", items = items })
  vim.cmd("copen")
end

vim.keymap.set("n", "<leader>r", show, {
  desc = "Recent project files (user)",
  silent = true,
})
