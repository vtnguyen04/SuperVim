-- ============================================
-- CORE OPTIONS - Cấu hình cơ bản của Neovim
-- ============================================

local M = {}

function M.setup()
  -- Leader keys - Quan trọng nhất, phải đặt trước tiên
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- UI & Display
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = "yes"
  vim.opt.cursorline = true
  vim.opt.termguicolors = true
  vim.opt.showmode = false
  vim.opt.cmdheight = 1
  vim.opt.scrolloff = 8
  vim.opt.sidescrolloff = 8
  vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" -- Normal/Visual: block, Insert: beam

  -- Editor behavior
  vim.opt.mouse = "a"
  vim.opt.clipboard = "unnamedplus"
  vim.opt.breakindent = true
  vim.opt.undofile = true
  vim.opt.swapfile = false
  vim.opt.backup = false

  -- Search
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.hlsearch = false
  vim.opt.incsearch = true

  -- Performance
  vim.opt.updatetime = 250
  vim.opt.timeoutlen = 300
  vim.opt.lazyredraw = false

  -- Splits
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- Indentation
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.autoindent = true

  -- Completion
  vim.opt.completeopt = { "menu", "menuone", "noselect" }
  vim.opt.pumheight = 10

  -- Folding (modern TreeSitter-based)
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel = 99
  vim.opt.foldenable = false
end

return M