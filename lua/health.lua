-- ============================================
-- HEALTH CHECK - SuperVim health diagnostics
-- ============================================

local M = {}

local health = vim.health

-- Safe require with fallback
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    return nil
  end
  return result
end

local utils = safe_require("utils") or safe_require("utils.init")

-- Fallback functions if utils module not available
if not utils then
  utils = {
    has_executable = function(cmd)
      return vim.fn.executable(cmd) == 1
    end,
    get_python_path = function()
      return vim.fn.executable("python3") == 1 and "python3" or "python"
    end,
    is_git_repo = function()
      return vim.fn.finddir(".git", ".;") ~= ""
    end,
    get_git_branch = function()
      local handle = io.popen("git branch --show-current 2>/dev/null")
      if handle then
        local branch = handle:read("*a"):gsub("\n", "")
        handle:close()
        return branch ~= "" and branch or nil
      end
      return nil
    end,
  }
end

function M.check()
  -- Start health check
  health.start("SuperVim Configuration")

  -- Check Neovim version
  local nvim_version = vim.version()
  if vim.fn.has("nvim-0.9") == 1 then
    health.ok(string.format("Neovim version: %s.%s.%s", nvim_version.major, nvim_version.minor, nvim_version.patch))
  else
    health.error("Neovim 0.9+ required. Current version: " .. vim.version())
  end

  -- Check Git
  if utils.has_executable("git") then
    local git_version = vim.fn.system("git --version"):gsub("\n", "")
    health.ok("Git: " .. git_version)
  else
    health.error("Git not found - required for plugin management")
  end

  -- Check Node.js
  if utils.has_executable("node") then
    local node_version = vim.fn.system("node --version"):gsub("\n", "")
    health.ok("Node.js: " .. node_version)
  else
    health.warn("Node.js not found - some LSP servers require it")
  end

  -- Check Python
  local python_path = utils.get_python_path()
  if utils.has_executable(python_path) then
    local python_version = vim.fn.system(python_path .. " --version"):gsub("\n", "")
    health.ok("Python: " .. python_version .. " (" .. python_path .. ")")
  else
    health.warn("Python not found - required for Python development")
  end

  -- Check essential tools
  local tools = {
    { cmd = "rg", name = "ripgrep", required = true },
    { cmd = "fd", name = "fd-find", required = false },
    { cmd = "lazygit", name = "LazyGit", required = false },
    { cmd = "make", name = "make", required = false },
  }

  for _, tool in ipairs(tools) do
    if utils.has_executable(tool.cmd) then
      health.ok(tool.name .. " found")
    else
      if tool.required then
        health.error(tool.name .. " not found - required for SuperVim functionality")
      else
        health.warn(tool.name .. " not found - optional but recommended")
      end
    end
  end

  -- Check terminal capabilities
  health.start("Terminal Capabilities")

  if vim.env.TERM_PROGRAM then
    health.ok("Terminal: " .. vim.env.TERM_PROGRAM)
  else
    health.info("Terminal: Unknown")
  end

  if vim.o.termguicolors then
    health.ok("True color support enabled")
  else
    health.warn("True color support disabled - colors may not display correctly")
  end

  -- Check Nerd Font
  local nerd_font_test = "󰀘 󰀨 󰀯 󰀵"
  health.info("Nerd Font test: " .. nerd_font_test)
  health.info("If you see boxes or question marks above, install a Nerd Font")

  -- Check plugins
  health.start("Plugin Status")

  local lazy_ok, lazy = pcall(require, "lazy")
  if lazy_ok then
    local stats = lazy.stats()
    health.ok(string.format("Lazy.nvim: %d plugins loaded, %d startuptime: %.2fms",
      stats.loaded, stats.count, stats.startuptime))
  else
    health.error("Lazy.nvim not found")
  end

  -- Check LSP servers
  local lsp_ok, _ = pcall(require, "lspconfig")
  if lsp_ok then
    local clients = vim.lsp.get_active_clients()
    if #clients > 0 then
      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      health.ok("Active LSP servers: " .. table.concat(client_names, ", "))
    else
      health.info("No active LSP servers")
    end
  else
    health.error("LSP configuration not loaded")
  end

  -- Check Mason
  local mason_ok, mason = pcall(require, "mason")
  if mason_ok then
    local registry = require("mason-registry")
    local installed_packages = registry.get_installed_packages()
    health.ok(string.format("Mason: %d packages installed", #installed_packages))
  else
    health.warn("Mason not loaded")
  end

  -- Check configuration files
  health.start("Configuration Files")

  local config_files = {
    "lua/config/options.lua",
    "lua/config/keymaps.lua",
    "lua/config/autocmds.lua",
    "lua/config/lazy.lua",
  }

  for _, file in ipairs(config_files) do
    local path = vim.fn.stdpath("config") .. "/" .. file
    if vim.fn.filereadable(path) == 1 then
      health.ok(file .. " loaded")
    else
      health.error(file .. " not found")
    end
  end

  -- Check plugin directories
  local plugin_dirs = {
    "lua/plugins/ui.lua",
    "lua/plugins/editor.lua",
    "lua/plugins/lsp.lua",
    "lua/plugins/git.lua",
    "lua/plugins/python.lua",
    "lua/plugins/treesitter.lua",
    "lua/plugins/debug.lua",
  }

  for _, file in ipairs(plugin_dirs) do
    local path = vim.fn.stdpath("config") .. "/" .. file
    if vim.fn.filereadable(path) == 1 then
      health.ok(file .. " configured")
    else
      health.warn(file .. " not found")
    end
  end

  -- Performance check
  health.start("Performance")

  local start_time = vim.fn.reltime()
  vim.fn.reltimestr(start_time)
  local end_time = vim.fn.reltime()
  local startup_time = vim.fn.reltimefloat(vim.fn.reltime(start_time, end_time))

  if startup_time < 0.1 then
    health.ok(string.format("Fast startup time: %.2fms", startup_time * 1000))
  elseif startup_time < 0.2 then
    health.info(string.format("Good startup time: %.2fms", startup_time * 1000))
  else
    health.warn(string.format("Slow startup time: %.2fms - consider optimizing", startup_time * 1000))
  end

  -- Memory usage
  local memory_mb = vim.fn.luaeval("collectgarbage('count')") / 1024
  if memory_mb < 50 then
    health.ok(string.format("Low memory usage: %.1fMB", memory_mb))
  elseif memory_mb < 100 then
    health.info(string.format("Moderate memory usage: %.1fMB", memory_mb))
  else
    health.warn(string.format("High memory usage: %.1fMB", memory_mb))
  end

  -- Virtual environment check (Python)
  health.start("Development Environment")

  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    health.ok("Python virtual environment: " .. venv)
  else
    health.info("No Python virtual environment detected")
  end

  -- Git repository check
  if utils.is_git_repo() then
    local branch = utils.get_git_branch()
    if branch then
      health.ok("Git repository: branch " .. branch)
    else
      health.ok("Git repository detected")
    end
  else
    health.info("Not in a Git repository")
  end

  health.info("SuperVim health check completed!")
end

return M