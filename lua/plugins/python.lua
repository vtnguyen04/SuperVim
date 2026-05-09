-- ============================================
-- PYTHON SPECIFIC PLUGINS
-- ============================================

return {
  -- Python virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    config = function()
      require("venv-selector").setup({
        settings = {
          search = {
            anaconda_base = {
              command = "find ~/anaconda3/envs ~/miniconda3/envs ~/.conda/envs -maxdepth 1 -name '*' -type d",
              type = "anaconda",
            },
            anaconda_envs = {
              command = "find ~/anaconda3/envs ~/miniconda3/envs ~/.conda/envs -maxdepth 1 -name '*' -type d",
              type = "anaconda",
            },
            my_venvs = {
              command = "find ~/python-envs -maxdepth 1 -type d -name '*env*'",
              type = "venv",
            },
            workspace_venvs = {
              command = "find . -maxdepth 5 -type d -name '.venv' -o -name 'venv' -o -name 'env'",
              type = "venv",
            },
          },
          options = {
            on_telescope_result_callback = function(filename)
              return filename
            end,
            enable_default_searches = true,
            enable_cached_searches = true,
            cached_venv_automatic_activation = true,
            activate_venv_in_terminal = true,
            set_environment_variables = true,
            notify_user_on_venv_activation = true,
          },
        },
      })
    end,
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Virtual Environment" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached Python Virtual Environment" },
    },
  },

  -- Python debugging with DAP
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap_python = require("dap-python")

      -- Try to find python executable
      local function get_python_path()
        local venv_path = vim.env.VIRTUAL_ENV
        if venv_path then
          return venv_path .. "/bin/python"
        end

        -- Fallback to system python
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
      end

      dap_python.setup(get_python_path())

      -- Custom configurations for different Python scenarios
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input('Arguments: ')
          return vim.split(args_string, " +")
        end,
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        env = function()
          local variables = {}
          for k, v in pairs(vim.fn.environ()) do
            table.insert(variables, string.format("%s=%s", k, v))
          end
          return variables
        end,
      })

      -- Django debugging
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = vim.fn.getcwd() .. '/manage.py',
        args = { 'runserver', '--noreload' },
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        env = {
          DJANGO_SETTINGS_MODULE = "myproject.settings",
          DEBUG = "1"
        },
      })

      -- Flask debugging
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Flask',
        module = 'flask',
        args = { 'run', '--no-debugger', '--no-reload' },
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        env = {
          FLASK_APP = "app.py",
          FLASK_ENV = "development",
        },
      })
    end,
    keys = {
      {
        "<leader>dpr",
        function()
          require('dap-python').test_method()
        end,
        desc = "Debug Python Test Method",
        ft = "python",
      },
      {
        "<leader>dpc",
        function()
          require('dap-python').test_class()
        end,
        desc = "Debug Python Test Class",
        ft = "python",
      },
    },
  },

  -- Python testing with pytest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },
    ft = "python",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = function()
              local venv_path = vim.env.VIRTUAL_ENV
              if venv_path then
                return venv_path .. "/bin/python"
              end
              return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
            end,
          }),
        },
        discovery = {
          enabled = true,
        },
        running = {
          concurrent = true,
        },
        summary = {
          enabled = true,
          animated = true,
        },
      })
    end,
    keys = {
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
        ft = "python",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run file tests",
        ft = "python",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary",
        ft = "python",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Open test output",
        ft = "python",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({strategy = "dap"})
        end,
        desc = "Debug nearest test",
        ft = "python",
      },
    },
  },

  -- Enhanced Python indentation
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },

  -- Python docstring generator
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup({
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings"
            }
          }
        }
      })
    end,
    keys = {
      {
        "<leader>nf",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "Generate function docstring",
        ft = "python",
      },
      {
        "<leader>nc",
        function()
          require("neogen").generate({ type = "class" })
        end,
        desc = "Generate class docstring",
        ft = "python",
      },
    },
  },
}