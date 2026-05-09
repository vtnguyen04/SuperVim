--[[
██╗   ██╗██╗███╗   ███╗
██║   ██║██║████╗ ████║
██║   ██║██║██╔████╔██║
╚██╗ ██╔╝██║██║╚██╔╝██║
 ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═══╝  ╚═╝╚═╝     ╚═╝

🚀 SuperVim - VSCode Alternative for Neovim
A comprehensive, modern Neovim configuration that rivals VSCode
Author: SuperVim Team
Version: 2.0
]]--

-- ============================================
-- CORE CONFIGURATION BOOTSTRAP
-- ============================================

-- Set leader keys FIRST - absolutely critical for keymaps to work
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration modules
require("config.options").setup()
require("config.keymaps").setup()
require("config.autocmds").setup()

-- Bootstrap lazy.nvim and load plugins
require("config.lazy").setup()

-- Setup LSP keymaps on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    require("config.keymaps").lsp_keymaps(ev.buf)
  end,
})
