-- ============================================
-- AUTOCMDS - Auto commands và events
-- ============================================

local M = {}

function M.setup()
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = vim.api.nvim_create_augroup

  -- ==========================================
  -- GENERAL AUTOCMDS
  -- ==========================================

  -- Highlight on yank
  local highlight_group = augroup("YankHighlight", { clear = true })
  autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })

  -- Auto-resize splits when Vim is resized
  local resize_group = augroup("ResizeSplits", { clear = true })
  autocmd("VimResized", {
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
    group = resize_group,
  })

  -- Auto-create directories when saving files
  local auto_create_dir = augroup("AutoCreateDir", { clear = true })
  autocmd("BufWritePre", {
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
    group = auto_create_dir,
  })

  -- Remove trailing whitespace on save
  local trim_whitespace = augroup("TrimWhitespace", { clear = true })
  autocmd("BufWritePre", {
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", save_cursor)
    end,
    group = trim_whitespace,
  })

  -- ==========================================
  -- FILETYPE SPECIFIC AUTOCMDS
  -- ==========================================

  -- Python specific settings
  local python_group = augroup("PythonSettings", { clear = true })
  autocmd("FileType", {
    pattern = "python",
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = true
      vim.opt_local.textwidth = 88  -- Black formatter standard
    end,
    group = python_group,
  })

  -- JavaScript/TypeScript settings
  local js_group = augroup("JSSettings", { clear = true })
  autocmd("FileType", {
    pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function()
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.expandtab = true
    end,
    group = js_group,
  })

  -- Go settings
  local go_group = augroup("GoSettings", { clear = true })
  autocmd("FileType", {
    pattern = "go",
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = false  -- Go uses tabs
    end,
    group = go_group,
  })

  -- ==========================================
  -- UI ENHANCEMENTS
  -- ==========================================

  -- Show cursor line only in active window
  local cursorline_group = augroup("CursorLine", { clear = true })
  autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
    callback = function()
      vim.opt_local.cursorline = true
    end,
    group = cursorline_group,
  })

  autocmd("WinLeave", {
    callback = function()
      vim.opt_local.cursorline = false
    end,
    group = cursorline_group,
  })

  -- Check if file changed outside of Vim
  local checktime_group = augroup("CheckTime", { clear = true })
  autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    callback = function()
      if vim.o.buftype ~= "nofile" then
        vim.cmd("checktime")
      end
    end,
    group = checktime_group,
  })

  -- ==========================================
  -- LSP SPECIFIC AUTOCMDS
  -- ==========================================

  -- Auto-format on save (for specific filetypes)
  local format_group = augroup("FormatOnSave", { clear = true })
  autocmd("BufWritePre", {
    pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.go", "*.rust", "*.rs" },
    callback = function()
      -- Only format if conform.nvim is available
      local ok, conform = pcall(require, "conform")
      if ok then
        conform.format({ async = false, lsp_fallback = true })
      end
    end,
    group = format_group,
  })

  -- Close certain filetypes with <q>
  local close_with_q = augroup("CloseWithQ", { clear = true })
  autocmd("FileType", {
    pattern = {
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "man",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
    group = close_with_q,
  })

  -- ==========================================
  -- TERMINAL AUTO-INSERT - Tự động vào chế độ gõ khi mở Terminal
  -- ==========================================
  local terminal_group = augroup("TerminalAutoInsert", { clear = true })
  autocmd({ "BufEnter", "WinEnter", "TermOpen" }, {
    pattern = "term://*",
    callback = function()
      vim.cmd("startinsert")
    end,
    group = terminal_group,
  })

  -- ==========================================
  -- DEVELOPER SYNC (SAFE & GENERIC)
  -- Tự động đồng bộ nếu có file .supervim_dev
  -- ==========================================
  local cwd = vim.fn.getcwd()
  local target = vim.fn.expand("$HOME/.config/nvim")
  local dev_marker = cwd .. "/.supervim_dev"

  -- Chỉ chạy nếu có file marker và cwd không phải là thư mục config hệ thống
  if vim.fn.filereadable(dev_marker) == 1 and cwd ~= target then
    local sync_group = augroup("SuperVimDevSync", { clear = true })
    autocmd("BufWritePost", {
      pattern = cwd .. "/*",
      callback = function()
        vim.fn.jobstart({"cp", "-r", cwd .. "/.", target}, {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("✅ Dev Sync: Hệ thống đã được cập nhật!", vim.log.levels.INFO)
            end
          end
        })
      end,
      group = sync_group,
    })
  end
end

return M