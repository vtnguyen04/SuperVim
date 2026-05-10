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

  -- Resize with Ctrl + Shift + hjkl (or Alt as fallback)
  keymap("n", "<C-S-k>", ":resize -2<CR>", opts)
  keymap("n", "<C-S-j>", ":resize +2<CR>", opts)
  keymap("n", "<C-S-h>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-S-l>", ":vertical resize +2<CR>", opts)

  -- Alt + hjkl resize fallback (very reliable across terminals)
  keymap("n", "<A-k>", ":resize -2<CR>", opts)
  keymap("n", "<A-j>", ":resize +2<CR>", opts)
  keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
  keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

  -- Buffer navigation (VSCode-like tabs)
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)
  keymap("n", "<leader>bd", function() 
    local ok, bufremove = pcall(require, "mini.bufremove")
    if ok then
      bufremove.delete(0, false)
    else
      vim.cmd("bdelete")
    end
  end, { desc = "Delete buffer (Keep window)" })

  -- Tab navigation (actually buffer navigation for better workflow)
  keymap("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Next buffer" })
  keymap("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
  keymap("n", "<leader>tn", "<cmd>enew<cr>", { desc = "New buffer" })
  keymap("n", "<leader>tc", function()
    local ok, bufremove = pcall(require, "mini.bufremove")
    if ok then
      bufremove.delete(0, false)
    else
      vim.cmd("bdelete")
    end
  end, { desc = "Close buffer (Keep window)" })

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

  -- Move text up and down (Moved to Ctrl+Alt+j/k to avoid conflict with resize)
  keymap("n", "<C-A-j>", ":m .+1<CR>==", opts)
  keymap("n", "<C-A-k>", ":m .-2<CR>==", opts)
  keymap("v", "<C-A-j>", ":m '>+1<CR>gv=gv", opts)
  keymap("v", "<C-A-k>", ":m '<-2<CR>gv=gv", opts)

  -- Better indenting
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- Clear highlights
  keymap("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

  -- Save and quit shortcuts (VSCode-like)
  keymap("n", "<C-s>", ":w<CR>", { desc = "Save file" })
  keymap("n", "<C-q>", ":qa<CR>", { desc = "Quit all" })

  -- ==========================================
  -- TERMINAL MODE KEYMAPS (Frictionless navigation)
  -- ==========================================
  -- Escape terminal mode easily
  keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })
  keymap("t", "jk", [[<C-\><C-n>]], { desc = "Escape terminal mode" })

  -- Direct window navigation from terminal
  keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move to left window" })
  keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move to bottom window" })
  keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move to top window" })
  keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move to right window" })

  -- Resize windows directly from terminal
  keymap("t", "<A-h>", [[<C-\><C-n>:vertical resize -2<CR>i]], { desc = "Resize left" })
  keymap("t", "<A-j>", [[<C-\><C-n>:resize +2<CR>i]], { desc = "Resize down" })
  keymap("t", "<A-k>", [[<C-\><C-n>:resize -2<CR>i]], { desc = "Resize up" })
  keymap("t", "<A-l>", [[<C-\><C-n>:vertical resize +2<CR>i]], { desc = "Resize right" })

  -- Ctrl+Shift fallbacks for terminal
  keymap("t", "<C-S-h>", [[<C-\><C-n>:vertical resize -2<CR>i]], { desc = "Resize left" })
  keymap("t", "<C-S-j>", [[<C-\><C-n>:resize +2<CR>i]], { desc = "Resize down" })
  keymap("t", "<C-S-k>", [[<C-\><C-n>:resize -2<CR>i]], { desc = "Resize up" })
  keymap("t", "<C-S-l>", [[<C-\><C-n>:vertical resize +2<CR>i]], { desc = "Resize right" })

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

  -- Git operations
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
  -- Zen mode and focus
  keymap("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })
  keymap("n", "<leader>ut", "<cmd>Twilight<cr>", { desc = "Twilight" })

  -- Window and layout management
  keymap("n", "<leader>uw", function()
    local ok, wp = pcall(require, "window-picker")
    if ok then
      local picked_window_id = wp.pick_window() or vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win(picked_window_id)
    end
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
    local ok, notify = pcall(require, "notify")
    if ok then
      notify.dismiss({ silent = true, pending = true })
    end
  end, { desc = "Dismiss notifications" })

  -- Terminal enhancements
  keymap("n", "<leader>tn", function()
    require("toggleterm.terminal").Terminal:new({ cmd = "node", direction = "float" }):toggle()
  end, { desc = "Node REPL" })

  keymap("n", "<leader>tp", function()
    require("toggleterm.terminal").Terminal:new({ cmd = "python3", direction = "float" }):toggle()
  end, { desc = "Python REPL" })

  -- Diagnostics/quickfix
  -- No dummy mapping for <leader>x

  -- Additional keymaps to match which-key display
  -- No dummy mappings for <leader>v, <leader>r, <leader>n

  -- Format and lint
  keymap("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, { desc = "Format file or range (in visual mode)" })

  -- Diagnostics
  keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
  keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  keymap("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

  -- ==========================================
  -- LSP KEYMAPS (sẽ được gọi khi LSP attach)
  -- ==========================================
  M.lsp_keymaps = function(bufnr)
    local lsp_opts = { noremap = true, silent = true, buffer = bufnr }

    -- Navigation (Safe version with capability checks)
    local function lsp_method_check(method, client_capability, fallback_fn)
      return function()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        local supported = false
        for _, client in ipairs(clients) do
          if client.supports_method(method) or (client_capability and client.server_capabilities[client_capability]) then
            supported = true
            break
          end
        end
        if supported then
          fallback_fn()
        else
          vim.notify("Tính năng này không được hỗ trợ bởi LSP hiện tại", vim.log.levels.WARN)
        end
      end
    end

    keymap("n", "gD", lsp_method_check("textDocument/declaration", "declarationProvider", vim.lsp.buf.declaration), vim.tbl_extend("force", lsp_opts, { desc = "Go to declaration" }))
    keymap("n", "gd", lsp_method_check("textDocument/definition", "definitionProvider", vim.lsp.buf.definition), vim.tbl_extend("force", lsp_opts, { desc = "Go to definition" }))
    keymap("n", "gi", lsp_method_check("textDocument/implementation", "implementationProvider", vim.lsp.buf.implementation), vim.tbl_extend("force", lsp_opts, { desc = "Go to implementation" }))
    keymap("n", "gt", lsp_method_check("textDocument/typeDefinition", "typeDefinitionProvider", vim.lsp.buf.type_definition), vim.tbl_extend("force", lsp_opts, { desc = "Go to type definition" }))

    -- Hover and help (Safe version)
    keymap("n", "K", lsp_method_check("textDocument/hover", "hoverProvider", vim.lsp.buf.hover), vim.tbl_extend("force", lsp_opts, { desc = "Hover Documentation" }))
    keymap("n", "<C-k>", lsp_method_check("textDocument/signatureHelp", "signatureHelpProvider", vim.lsp.buf.signature_help), vim.tbl_extend("force", lsp_opts, { desc = "Signature help" }))

    -- Code actions
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", lsp_opts, { desc = "Code action" }))
    keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", lsp_opts, { desc = "Rename" }))

    -- Window Management Shortcuts (New)
    keymap("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
    keymap("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split window horizontally" })
    keymap("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close current window" })
    keymap("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close all other windows" })

    -- Multi-Terminal Management (Advanced - Fresh Instances)
    local function open_terminal(direction)
      -- Find all active terminals
      local terminals = require("toggleterm.terminal").get_all()
      local next_id = 1
      -- Find the highest ID and increment it to guarantee a NEW terminal instance
      for _, t in ipairs(terminals) do
        if t.id >= next_id then next_id = t.id + 1 end
      end
      
      -- Force opening as a NEW terminal by using the unique ID
      vim.cmd(next_id .. "ToggleTerm direction=" .. direction)
      vim.notify("Opened NEW Terminal #" .. next_id, vim.log.levels.INFO)
    end

    keymap("n", "<leader>Tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Last Terminal" })
    keymap("n", "<leader>Tn", function() open_terminal("float") end, { desc = "New Float Terminal" })
    keymap("n", "<leader>Th", function() open_terminal("horizontal") end, { desc = "New Horizontal Split" })
    keymap("n", "<leader>Tv", function() open_terminal("vertical") end, { desc = "New Vertical Split" })
    
    for i = 1, 5 do
      keymap("n", "<leader>T" .. i, "<cmd>" .. i .. "ToggleTerm<cr>", { desc = "Terminal " .. i })
    end
    
    keymap("n", "<leader>Ta", function() require("toggleterm").toggle_all() end, { desc = "Toggle all terminals" })
    keymap("n", "<leader>Tk", function()
      local term = require("toggleterm.terminal")
      local id = vim.v.count > 0 and vim.v.count or nil
      if id then
        local t = term.get(id)
        if t then t:shutdown() vim.notify("Terminal " .. id .. " closed") end
      else
        -- Robust focused terminal detection
        local terminals = term.get_all()
        local focused_t = nil
        local cur_win = vim.api.nvim_get_current_win()
        for _, t in ipairs(terminals) do
          if t:is_open() and t.window == cur_win then
            focused_t = t
            break
          end
        end
        
        -- Fallback to last opened if no terminal is focused
        if not focused_t and #terminals > 0 then
          focused_t = terminals[#terminals]
        end

        if focused_t then 
          focused_t:shutdown() 
          vim.notify("Terminal " .. focused_t.id .. " closed") 
        else
          vim.notify("No active terminal to close", vim.log.levels.WARN)
        end
      end
    end, { desc = "Kill terminal (e.g. 2<leader>Tk)" })

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