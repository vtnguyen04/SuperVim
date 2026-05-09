-- ============================================
-- LAZY.NVIM BOOTSTRAP - Plugin manager setup
-- ============================================

local M = {}

function M.setup()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      lazyrepo,
      lazypath
    })

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end

  vim.opt.rtp:prepend(lazypath)

  -- Configure lazy.nvim
  require("lazy").setup({
    spec = {
      { import = "plugins" },  -- Import all plugins from lua/plugins/
    },
    defaults = {
      lazy = true,  -- plugins are lazy-loaded by default for better performance
      version = false,  -- always use the latest git commit
    },
    install = {
      colorscheme = { "tokyonight", "habamax" }
    },
    checker = {
      enabled = true,  -- automatically check for plugin updates
      notify = false,  -- don't notify about updates
    },
    change_detection = {
      enabled = true,
      notify = false,
    },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        -- disable some rtp plugins for better performance
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    ui = {
      border = "rounded",
      backdrop = 60,
    },
  })
end

return M