-- ============================================
-- SESSION PLUGINS - Session management
-- ============================================

return {
  -- Auto session management
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = nil,
      auto_restore_enabled = nil,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_session_use_git_branch = false,
      auto_session_create_enabled = function()
        local cmd = "git rev-parse --is-inside-work-tree"
        return vim.fn.system(cmd):find("true") ~= nil
      end,
    },
    keys = {
      { "<leader>qs", "<cmd>SessionSave<cr>", desc = "Save session" },
      { "<leader>qr", "<cmd>SessionRestore<cr>", desc = "Restore session" },
      { "<leader>qd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
    },
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
      ignore_lsp = {},
      exclude_dirs = {},
      show_hidden = false,
      silent_chdir = true,
      scope_chdir = "global",
      datapath = vim.fn.stdpath("data"),
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      -- Safe telescope extension loading
      vim.schedule(function()
        local ok, telescope = pcall(require, "telescope")
        if ok then
          telescope.load_extension("projects")
        end
      end)
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },

  -- Persistence for session restoration
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}