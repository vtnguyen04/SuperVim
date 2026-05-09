-- ============================================
-- LAYOUT MANAGER - IDE-like layouts and window management
-- Professional workspace management
-- ============================================

return {
  -- Advanced window management like IDEs
  {
    "folke/edgy.nvim",
    lazy = false,
    opts = function()
      local opts = {
        bottom = {
          {
            ft = "toggleterm",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf)
              return not vim.b[buf].lazyterm_cmd
            end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
          { ft = "spectre_panel", size = { height = 0.4 } },
          { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
        },
        left = {
          {
            title = "Neo-Tree",
            ft = "neo-tree",
            filter = function(buf)
              return vim.b[buf].neo_tree_source == "filesystem"
            end,
            pinned = true,
            open = function()
              vim.api.nvim_input("<esc><space>e")
            end,
            size = { height = 0.5 },
          },
          { title = "Neo-Tree Git", ft = "neo-tree", filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end },
          { title = "Neo-Tree Buffers", ft = "neo-tree", filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end },
          {
            ft = "Outline",
            pinned = true,
            open = "SymbolsOutline",
          },
          { title = "Neotest Summary", ft = "neotest-summary" },
        },
        right = {
          {
            title = "Copilot Chat",
            ft = "copilot-chat",
          },
        },
        keys = {
          -- increase width
          ["<c-Right>"] = function(win) win:resize("width", 2) end,
          -- decrease width
          ["<c-Left>"] = function(win) win:resize("width", -2) end,
          -- increase height
          ["<c-Up>"] = function(win) win:resize("height", 2) end,
          -- decrease height
          ["<c-Down>"] = function(win) win:resize("height", -2) end,
        },
      }
      return opts
    end,
  },

  -- Beautiful dashboard with animations
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = function()
      local logo = [[
██████╗ ██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗
██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██║████╗ ████║
███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║██║██╔████╔██║
╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
███████║╚██████╔╝██║     ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

      🚀 The Ultimate Neovim Experience • Tokyo Night Edition
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            {
              action = "Telescope find_files",
              desc = " Find file",
              icon = " ",
              key = "f",
            },
            {
              action = "ene | startinsert",
              desc = " New file",
              icon = " ",
              key = "n",
            },
            {
              action = "Telescope oldfiles",
              desc = " Recent files",
              icon = " ",
              key = "r",
            },
            {
              action = "Telescope live_grep",
              desc = " Find text",
              icon = " ",
              key = "g",
            },
            {
              action = [[lua require("lazyvim.util").telescope.config_files()()]],
              desc = " Config",
              icon = " ",
              key = "c",
            },
            {
              action = 'lua require("persistence").load()',
              desc = " Restore Session",
              icon = " ",
              key = "s",
            },
            {
              action = "LazyExtras",
              desc = " Lazy Extras",
              icon = " ",
              key = "x",
            },
            {
              action = "Lazy",
              desc = " Lazy",
              icon = "󰒲 ",
              key = "l",
            },
            {
              action = "qa",
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },

  -- Smooth scrolling animations
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      mappings = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      hide_cursor = true,
      stop_eof = true,
      use_local_scrolloff = false,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = nil,
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
    },
  },

  -- Beautiful winbar with file path and symbols
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = {
        normal = { fg = "#c0caf5" },
        ellipsis = { fg = "#737aa2" },
        separator = { fg = "#737aa2" },
        modified = { fg = "#e0af68" },
        dirname = { fg = "#9ece6a" },
        basename = { bold = true, fg = "#7aa2f7" },
        context = {},
        context_file = { fg = "#7aa2f7" },
        context_module = { fg = "#bb9af7" },
        context_namespace = { fg = "#bb9af7" },
        context_package = { fg = "#bb9af7" },
        context_class = { fg = "#e0af68" },
        context_method = { fg = "#9ece6a" },
        context_property = { fg = "#73daca" },
        context_field = { fg = "#73daca" },
        context_constructor = { fg = "#7aa2f7" },
        context_enum = { fg = "#e0af68" },
        context_interface = { fg = "#e0af68" },
        context_function = { fg = "#9ece6a" },
        context_variable = { fg = "#f7768e" },
        context_constant = { fg = "#ff9e64" },
        context_string = { fg = "#9ece6a" },
        context_number = { fg = "#ff9e64" },
        context_boolean = { fg = "#ff9e64" },
        context_array = { fg = "#7aa2f7" },
        context_object = { fg = "#7aa2f7" },
        context_key = { fg = "#73daca" },
        context_null = { fg = "#565f89" },
        context_enum_member = { fg = "#73daca" },
        context_struct = { fg = "#e0af68" },
        context_event = { fg = "#bb9af7" },
        context_operator = { fg = "#89ddff" },
        context_type_parameter = { fg = "#73daca" },
      },
      show_dirname = true,
      show_basename = true,
      show_modified = true,
      modified = function(bufnr) return vim.bo[bufnr].modified end,
      ellipsis = true,
      exclude_filetypes = { "netrw", "toggleterm" },
      show_navic = true,
      lead_custom_section = function() return " " end,
      custom_section = function() return " " end,
      context_follow_icon_color = true,
    },
  },

  -- Minimap for code navigation
  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 0")
      vim.cmd("let g:minimap_auto_start_win_enter = 0")
      vim.cmd("let g:minimap_highlight_range = 1")
      vim.cmd("let g:minimap_highlight_search = 1")
      vim.cmd("let g:minimap_git_colors = 1")
    end,
    keys = {
      { "<leader>mm", "<cmd>MinimapToggle<cr>", desc = "Toggle Minimap" },
    },
  },

  -- Beautiful fold preview
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = function()
      require('fold-preview').setup({
        default_keybindings = false,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        show_fold_level = true,
        show_close_button = true,
      })

      local keymap = vim.keymap
      local preview = require('fold-preview')

      keymap.set('n', 'zK', preview.show_preview_keymaps)
      keymap.set('n', 'zk', preview.toggle_preview)
    end
  },

  -- Zen mode for focused coding
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        kitty = {
          enabled = false,
          font = "+4",
        },
        alacritty = {
          enabled = false,
          font = "14",
        },
        wezterm = {
          enabled = false,
          font = "+4",
        },
      },
      on_open = function(win)
        vim.cmd([[
          hi ZenBg ctermbg=NONE guibg=#1a1b26
          set winhl=Normal:ZenBg
        ]])
      end,
      on_close = function()
        vim.cmd("set winhl=")
      end,
    },
  },

  -- Twilight for better focus
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = false,
      },
      context = 10,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {},
    },
  },
}