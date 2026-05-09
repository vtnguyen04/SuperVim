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
      -- Safe loading with error handling
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("Failed to load nvim-treesitter.configs", vim.log.levels.WARN)
        return
      end

      -- Filter duplicate languages
      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end

      configs.setup(opts)

      -- Fix for telescope compatibility with Neovim 0.12+
      -- Add ft_to_lang compatibility function if missing
      vim.schedule(function()
        local ts_lang = vim.treesitter.language
        if ts_lang and not ts_lang.ft_to_lang then
          ts_lang.ft_to_lang = function(ft)
            -- Common filetype to language mappings
            local ft_map = {
              javascriptreact = "javascript",
              typescriptreact = "typescript",
              bash = "bash",
              zsh = "bash",
              sh = "bash",
            }
            return ft_map[ft] or ft
          end
        end
      end)
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
    },
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