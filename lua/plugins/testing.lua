-- ============================================
-- TESTING PLUGINS - Test runners and utilities
-- ============================================

return {
  -- Neotest - Modern test runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    },
    keys = {
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test file" },
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug nearest test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle test output" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop tests" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle test watch" },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = function()
              -- Try to detect virtual environment
              local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
              if vim.fn.executable(venv_python) == 1 then
                return venv_python
              end
              return "python3"
            end,
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-go"),
          require("neotest-rust"),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            vim.cmd("Trouble quickfix")
          end,
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup(opts)
    end,
  },

  -- Test coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "Coverage", "CoverageLoad", "CoverageShow", "CoverageHide", "CoverageToggle", "CoverageClear" },
    config = function()
      require("coverage").setup({
        commands = true,
        highlights = {
          covered = { fg = "#C3E88D" },
          uncovered = { fg = "#F07178" },
        },
        signs = {
          covered = { hl = "CoverageCovered", text = "▎" },
          uncovered = { hl = "CoverageUncovered", text = "▎" },
        },
        summary = {
          min_coverage = 80.0,
        },
        lang = {
          python = {
            coverage_command = "coverage json --fail-under=0 -q -o -",
          },
        },
      })
    end,
    keys = {
      { "<leader>tc", "<cmd>Coverage<cr>", desc = "Test coverage" },
      { "<leader>tC", "<cmd>CoverageToggle<cr>", desc = "Toggle coverage" },
    },
  },

  -- Vim-test for broader test support
  {
    "vim-test/vim-test",
    dependencies = {
      "preservim/vimux",
    },
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    keys = {
      { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test nearest (vim-test)" },
      { "<leader>tT", "<cmd>TestFile<cr>", desc = "Test file (vim-test)" },
      { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test suite (vim-test)" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last (vim-test)" },
      { "<leader>tg", "<cmd>TestVisit<cr>", desc = "Visit test file" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "belowright"
      vim.g["test#neovim#preserve_screen"] = 1

      -- Python test configurations
      vim.g["test#python#pytest#executable"] = "python -m pytest"
      vim.g["test#python#pytest#options"] = "-v --tb=short"

      -- JavaScript test configurations
      vim.g["test#javascript#jest#executable"] = "npm test --"

      -- Go test configurations
      vim.g["test#go#gotest#options"] = "-v"
    end,
  },

  -- Database testing with vim-dadbod
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-ui",
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
          vim.g.db_ui_use_nerd_fonts = 1
          vim.g.db_ui_show_database_icon = 1
          vim.g.db_ui_force_echo_notifications = 1
          vim.g.db_ui_win_position = "left"
          vim.g.db_ui_winwidth = 80
        end,
        keys = {
          { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
          { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find buffer" },
          { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename buffer" },
          { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last query info" },
        },
      },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        init = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
              local ok, cmp = pcall(require, "cmp")
              if ok then
                local sources = vim.tbl_deep_extend("force", {}, cmp.get_config().sources or {})
                table.insert(sources, { name = "vim-dadbod-completion" })
                cmp.setup.buffer({ sources = sources })
              end
            end,
          })
        end,
      },
    },
  },

  -- HTTP client for API testing (Disabled - requires luarocks compilation)
  -- {
  --   "rest-nvim/rest.nvim",
  --   ft = "http",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("rest-nvim").setup({
  --       result_split_horizontal = false,
  --       result_split_in_place = false,
  --       stay_in_current_window_after_split = false,
  --       skip_ssl_verification = false,
  --       encode_url = true,
  --       highlight = {
  --         enabled = true,
  --         timeout = 150,
  --       },
  --       result = {
  --         show_url = true,
  --         show_headers = true,
  --         show_http_info = true,
  --         show_curl_command = false,
  --         formatters = {
  --           json = "jq",
  --           html = function(body)
  --             return vim.fn.system("tidy -i -q -", body)
  --           end,
  --         },
  --       },
  --       jump_to_request = false,
  --       env_file = ".env",
  --       custom_dynamic_variables = {},
  --       yank_dry_run = true,
  --     })
  --   end,
  --   keys = {
  --     { "<leader>rr", "<cmd>RestNvim<cr>", desc = "Run REST request" },
  --     { "<leader>rp", "<cmd>RestNvimPreview<cr>", desc = "Preview REST request" },
  --     { "<leader>rl", "<cmd>RestNvimLast<cr>", desc = "Re-run last request" },
  --   },
  -- },
}