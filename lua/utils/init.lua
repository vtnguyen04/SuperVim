-- ============================================
-- UTILS - Utility functions for SuperVim
-- ============================================

local M = {}

-- Check if a plugin is installed and available
function M.is_loaded(plugin)
  local ok, _ = pcall(require, plugin)
  return ok
end

-- Safe require - returns nil if module not found
function M.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    return nil
  end
  return result
end

-- Check if executable exists in PATH
function M.has_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Get project root directory
function M.get_root()
  local patterns = { ".git", "package.json", "pyproject.toml", "setup.py", "Cargo.toml", "go.mod" }
  local path = vim.fs.find(patterns, { upward = true })[1]
  return path and vim.fn.fnamemodify(path, ":p:h") or vim.loop.cwd()
end

-- Create buffer-local keymap
function M.buf_map(bufnr, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Get visual selection
function M.get_visual_selection()
  vim.cmd('noau normal! "vy"')
  return vim.fn.getreg("v")
end

-- Toggle boolean option
function M.toggle_option(option)
  vim.opt[option] = not vim.opt[option]:get()
  local status = vim.opt[option]:get() and "enabled" or "disabled"
  vim.notify(string.format("%s %s", option, status))
end

-- Format file size in human readable format
function M.format_file_size(bytes)
  local units = { "B", "KB", "MB", "GB", "TB" }
  local size = bytes
  local unit_index = 1

  while size >= 1024 and unit_index < #units do
    size = size / 1024
    unit_index = unit_index + 1
  end

  return string.format("%.1f %s", size, units[unit_index])
end

-- Check if running in WSL
function M.is_wsl()
  local version = vim.loop.os_uname().version
  return version and string.find(version:lower(), "microsoft") ~= nil
end

-- Check if running on macOS
function M.is_mac()
  return vim.loop.os_uname().sysname == "Darwin"
end

-- Check if running on Windows
function M.is_win()
  return vim.loop.os_uname().sysname:find("Windows") ~= nil
end

-- Get current git branch
function M.get_git_branch()
  local handle = io.popen("git branch --show-current 2>/dev/null")
  if handle then
    local branch = handle:read("*a"):gsub("\n", "")
    handle:close()
    return branch ~= "" and branch or nil
  end
  return nil
end

-- Check if current directory is a git repository
function M.is_git_repo()
  local git_dir = vim.fn.finddir(".git", ".;")
  return git_dir ~= ""
end

-- Get python executable from virtual environment
function M.get_python_path()
  -- Check for virtual environment
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    local python_path = venv .. "/bin/python"
    if M.has_executable(python_path) then
      return python_path
    end
  end

  -- Check for common venv directories
  local common_venvs = { ".venv", "venv", "env", ".env" }
  for _, venv_dir in ipairs(common_venvs) do
    local python_path = vim.fn.getcwd() .. "/" .. venv_dir .. "/bin/python"
    if M.has_executable(python_path) then
      return python_path
    end
  end

  -- Fallback to system python
  return "python3"
end

-- Check if running inside tmux
function M.is_tmux()
  return os.getenv("TMUX") ~= nil
end

-- Get terminal type
function M.get_terminal()
  if M.is_tmux() then
    return "tmux"
  elseif os.getenv("TERM_PROGRAM") == "iTerm.app" then
    return "iterm"
  elseif os.getenv("TERM_PROGRAM") == "vscode" then
    return "vscode"
  else
    return "unknown"
  end
end

-- Load all Lua files from a directory
function M.load_directory(dir)
  local path = vim.fn.stdpath("config") .. "/lua/" .. dir
  local files = vim.fn.glob(path .. "/*.lua", true, true)

  for _, file in ipairs(files) do
    local module = file:gsub(vim.fn.stdpath("config") .. "/lua/", ""):gsub("/", "."):gsub("%.lua$", "")
    M.safe_require(module)
  end
end

-- Deep merge two tables
function M.deep_merge(t1, t2)
  local result = {}

  for k, v in pairs(t1) do
    result[k] = v
  end

  for k, v in pairs(t2) do
    if type(v) == "table" and type(result[k]) == "table" then
      result[k] = M.deep_merge(result[k], v)
    else
      result[k] = v
    end
  end

  return result
end

-- Notify with icon and title
function M.notify(msg, level, title)
  local icons = {
    [vim.log.levels.ERROR] = "󰅚",
    [vim.log.levels.WARN] = "󰀪",
    [vim.log.levels.INFO] = "󰋽",
    [vim.log.levels.DEBUG] = "󰃤",
  }

  vim.notify(msg, level or vim.log.levels.INFO, {
    title = title or "SuperVim",
    icon = icons[level or vim.log.levels.INFO],
  })
end

-- Reload a Lua module (useful for development)
function M.reload_module(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end

-- Get current time in HH:MM format
function M.get_time()
  return os.date("%H:%M")
end

-- Get current date in YYYY-MM-DD format
function M.get_date()
  return os.date("%Y-%m-%d")
end

-- Check if string starts with prefix
function M.starts_with(str, prefix)
  return string.sub(str, 1, string.len(prefix)) == prefix
end

-- Check if string ends with suffix
function M.ends_with(str, suffix)
  return suffix == "" or string.sub(str, -string.len(suffix)) == suffix
end

-- Split string by delimiter
function M.split(str, delimiter)
  local result = {}
  local pattern = string.format("([^%s]+)", delimiter)

  for match in string.gmatch(str, pattern) do
    table.insert(result, match)
  end

  return result
end

return M