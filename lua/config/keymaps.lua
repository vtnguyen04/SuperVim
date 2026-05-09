-- ============================================
-- KEYMAPS - Cấu hình phím tắt VSCode-like
-- ============================================

local M = {}

function M.setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- ==========================================
  -- GENERAL KEYMAPS (Tổng quát)
  -- ==========================================

  -- Better window navigation
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-j>", "<C-w>j", opts)
  keymap("n", "<C-k>", "<C-w>k", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)

  -- Resize with arrows (VSCode-like)
  keymap("n", "<C-Up>", ":resize -2<CR>", opts)
  keymap("n", "<C-Down>", ":resize +2<CR>", opts)
  keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

  -- Buffer navigation (VSCode-like tabs)
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)
  keymap("n", "<leader>bd", ":bdelete<CR>", opts)

  -- Tab navigation (actually buffer navigation for better workflow)
  keymap("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Next buffer" })
  keymap("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
  keymap("n", "<leader>tn", "<cmd>enew<cr>", { desc = "New buffer" })
  keymap("n", "<leader>tc", "<cmd>bdelete<cr>", { desc = "Close buffer" })

  -- Quick buffer switching (Space + số) - works with bufferline
  for i = 1, 9 do
    keymap("n", "<leader>" .. i, function()
      -- Try to use bufferline navigation if available
      local ok, bufferline = pcall(require, "bufferline")
      if ok and bufferline.go_to_buffer then
        bufferline.go_to_buffer(i, true)
      else
        -- Fallback: switch to buffer by number
        vim.cmd("buffer " .. i)
      end
    end, { desc = "Go to buffer " .. i })
  end

  -- Move text up and down (Alt+j/k)
  keymap("n", "<A-j>", ":m .+1<CR>==", opts)
  keymap("n", "<A-k>", ":m .-2<CR>==", opts)
  keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
  keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

  -- Better indenting
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- Clear highlights
  keymap("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

  -- Save and quit shortcuts (VSCode-like)
  keymap("n", "<C-s>", ":w<CR>", { desc = "Save file" })
  keymap("n", "<C-q>", ":qa<CR>", { desc = "Quit all" })

  -- ==========================================
  -- PLUGIN SPECIFIC KEYMAPS
  -- ==========================================

  -- File Explorer (Neo-tree)
  keymap("n", "<leader>e", function()
    local ok, neotree = pcall(require, "neo-tree.command")
    if ok then
      neotree.execute({ action = "toggle" })
    else
      vim.cmd("Neotree toggle")
    end
  end, { desc = "Toggle file explorer" })

  keymap("n", "<leader>o", function()
    local ok, neotree = pcall(require, "neo-tree.command")
    if ok then
      neotree.execute({ action = "focus" })
    else
      vim.cmd("Neotree focus")
    end
  end, { desc = "Focus file explorer" })

  -- Telescope (Fuzzy finder)
  keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
  keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })
  keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
  keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
  keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

  -- Missing keymaps from which-key display

  -- Quit/Session management
  keymap("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })
  keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
  keymap("n", "<leader>qw", "<cmd>wqa<cr>", { desc = "Save and quit all" })

  -- Buffer operations
  keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
  keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })

  -- Code operations
  keymap("n", "<leader>c", function()
    vim.notify("Code operations - use ca, cr, cf, etc.", vim.log.levels.INFO)
  end, { desc = "Code operations" })

  -- Git operations
  keymap("n", "<leader>g", function()
    vim.notify("Git operations - use gg, gb, gd, etc.", vim.log.levels.INFO)
  end, { desc = "Git operations" })

  keymap("n", "<leader>gg", function()
    local ok = pcall(vim.cmd, "LazyGit")
    if not ok then
      vim.notify("LazyGit not available", vim.log.levels.WARN)
    end
  end, { desc = "Open LazyGit" })

  keymap("n", "<leader>gb", function()
    local ok = pcall(vim.cmd, "Gitsigns toggle_current_line_blame")
    if not ok then
      vim.notify("Gitsigns not available", vim.log.levels.WARN)
    end
  end, { desc = "Git blame" })

  -- Terminal operations
  keymap("n", "<leader>t", function()
    vim.notify("Terminal operations - use tf, th, tv, etc.", vim.log.levels.INFO)
  end, { desc = "Terminal operations" })

  keymap("n", "<leader>tf", function()
    local ok = pcall(vim.cmd, "ToggleTerm direction=float")
    if not ok then
      vim.notify("ToggleTerm not available", vim.log.levels.WARN)
    end
  end, { desc = "Terminal float" })

  keymap("n", "<leader>th", function()
    local ok = pcall(vim.cmd, "ToggleTerm direction=horizontal")
    if not ok then
      vim.notify("ToggleTerm not available", vim.log.levels.WARN)
    end
  end, { desc = "Terminal horizontal" })

  keymap("n", "<leader>tv", function()
    local ok = pcall(vim.cmd, "ToggleTerm direction=vertical size=40")
    if not ok then
      vim.notify("ToggleTerm not available", vim.log.levels.WARN)
    end
  end, { desc = "Terminal vertical" })

  -- UI operations - Enhanced SuperVim Interface
  keymap("n", "<leader>u", function()
    vim.notify("🎨 UI operations - Beautiful interface controls", vim.log.levels.INFO)
  end, { desc = "+ui" })

  -- Zen mode and focus
  keymap("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })
  keymap("n", "<leader>ut", "<cmd>Twilight<cr>", { desc = "Twilight" })

  -- Window and layout management
  keymap("n", "<leader>uw", function()
    local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
  end, { desc = "Pick window" })

  keymap("n", "<leader>um", "<cmd>MinimapToggle<cr>", { desc = "Toggle minimap" })
  keymap("n", "<leader>uf", "<cmd>FoldPreview toggle_preview<cr>", { desc = "Fold preview" })

  -- Bufferline enhancements
  keymap("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin buffer" })
  keymap("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
  keymap("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffers right" })
  keymap("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffers left" })
  keymap("n", "<leader>bg", "<cmd>BufferLineGroupClose<cr>", { desc = "Close buffer group" })

  -- Beautiful notifications
  keymap("n", "<leader>un", function()
    require("notify").dismiss({ silent = true, pending = true })
  end, { desc = "Dismiss notifications" })

  -- Terminal enhancements
  keymap("n", "<leader>tn", function()
    require("toggleterm.terminal").Terminal:new({ cmd = "node", direction = "float" }):toggle()
  end, { desc = "Node REPL" })

  keymap("n", "<leader>tp", function()
    require("toggleterm.terminal").Terminal:new({ cmd = "python3", direction = "float" }):toggle()
  end, { desc = "Python REPL" })

  -- Diagnostics/quickfix
  keymap("n", "<leader>x", function()
    vim.notify("Diagnostics operations - use xx, xX, etc.", vim.log.levels.INFO)
  end, { desc = "Diagnostics/quickfix" })

  -- Additional keymaps to match which-key display
  keymap("n", "<leader>v", function()
    vim.notify("Visual/selection operations", vim.log.levels.INFO)
  end, { desc = "+2 keymaps" })

  keymap("n", "<leader>r", function()
    vim.notify("Replace/refactor operations", vim.log.levels.INFO)
  end, { desc = "+1 keymap" })

  keymap("n", "<leader>n", function()
    vim.notify("Navigation operations", vim.log.levels.INFO)
  end, { desc = "+3 keymaps" })

  -- Format and lint
  keymap("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, { desc = "Format file or range (in visual mode)" })

  -- Diagnostics
  keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
  keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

  -- ==========================================
  -- LSP KEYMAPS (sẽ được gọi khi LSP attach)
  -- ==========================================
  M.lsp_keymaps = function(bufnr)
    local lsp_opts = { noremap = true, silent = true, buffer = bufnr }

    -- Navigation
    keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", lsp_opts, { desc = "Go to declaration" }))
    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", lsp_opts, { desc = "Go to definition" }))
    keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", lsp_opts, { desc = "Go to implementation" }))
    keymap("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", lsp_opts, { desc = "Go to type definition" }))

    -- Hover and help
    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", lsp_opts, { desc = "Hover Documentation" }))
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", lsp_opts, { desc = "Signature help" }))

    -- Code actions
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", lsp_opts, { desc = "Code action" }))
    keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", lsp_opts, { desc = "Rename" }))

    -- References với Telescope
    keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", vim.tbl_extend("force", lsp_opts, { desc = "Show references" }))

    -- Split navigation cho definitions
    keymap("n", "<leader>gd", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, vim.tbl_extend("force", lsp_opts, { desc = "Go to definition in vertical split" }))

    keymap("n", "<leader>gt", function()
      vim.cmd("tab split")
      vim.lsp.buf.definition()
    end, vim.tbl_extend("force", lsp_opts, { desc = "Go to definition in new tab" }))

    -- Mouse support
    keymap("n", "<C-LeftMouse>", "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>", lsp_opts)
  end
end

return M