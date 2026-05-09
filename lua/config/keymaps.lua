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

  -- Tab navigation
  keymap("n", "<leader>l", "<cmd>tabnext<cr>", { desc = "Tab tiếp theo" })
  keymap("n", "<leader>h", "<cmd>tabprevious<cr>", { desc = "Tab trước đó" })
  keymap("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Tab mới" })
  keymap("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Đóng tab" })

  -- Quick tab switching (Space + số)
  for i = 1, 9 do
    keymap("n", "<leader>" .. i, i .. "gt", { desc = "Đến tab " .. i })
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
  keymap("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
  keymap("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus file explorer" })

  -- Telescope (Fuzzy finder)
  keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
  keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })
  keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
  keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
  keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

  -- Git keymaps (sẽ được định nghĩa trong plugin)
  keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
  keymap("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Git blame" })

  -- Terminal
  keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal float" })
  keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal horizontal" })
  keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=40<cr>", { desc = "Terminal vertical" })

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