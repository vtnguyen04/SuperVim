-- ============================================
-- TREESITTER PLUGINS - Syntax highlighting và parsing
-- ============================================

return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "go",
        "rust",
        "css",
        "dockerfile",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      -- Enable auto-install for better experience
      opts.auto_install = true
      
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup(opts)
      else
        vim.notify("Treesitter chưa được cài đặt đầy đủ. Vui lòng chạy :Lazy sync", vim.log.levels.WARN)
      end
    end,
  },

  -- Treesitter context - Shows function signature at top
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 3,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
    },
    config = function(_, opts)
      -- Safe loading with error handling
      local ok, context = pcall(require, "treesitter-context")
      if not ok then
        vim.notify("Failed to load treesitter-context", vim.log.levels.WARN)
        return
      end
      context.setup(opts)
    end,
    keys = {
      {
        "<leader>ut",
        function()
          local ok, context = pcall(require, "treesitter-context")
          if ok then
            context.toggle()
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },

  -- Auto close and rename tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}