-- ============================================
-- ANIMATIONS - Visual effects and transitions
-- Smooth scrolling, cursor animations, highlights
-- ============================================

return {
  -- Smooth scrolling animation
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    opts = {
      mappings = {
        '<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb'
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = "sine",
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
    },
    config = function(_, opts)
      require('neoscroll').setup(opts)

      -- Beautiful easing functions
      local neoscroll = require('neoscroll')
      local keymap = {
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250; easing = 'sine' }) end,
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250; easing = 'sine' }) end,
        ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450; easing = 'sine' }) end,
        ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450; easing = 'sine' }) end,
        ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100; easing = 'sine' }) end,
        ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100; easing = 'sine' }) end,
        ["zt"]    = function() neoscroll.zt({ half_win_duration = 250; easing = 'sine' }) end,
        ["zz"]    = function() neoscroll.zz({ half_win_duration = 250; easing = 'sine' }) end,
        ["zb"]    = function() neoscroll.zb({ half_win_duration = 250; easing = 'sine' }) end,
      }
      local modes = { 'n', 'v', 'x' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },

  -- Beautiful cursor animations
  {
    "echasnovski/mini.animate",
    lazy = false,
    enabled = true,
    opts = function()
      -- Skip animation in headless mode
      if vim.g.vscode or vim.g.headless then
        return { cursor = { enable = false }, scroll = { enable = false } }
      end

      local animate = require("mini.animate")
      return {
        cursor = {
          enable = true,
          timing = animate.gen_timing.exponential({ duration = 150, unit = 'total' }),
          path = animate.gen_path.line({
            predicate = function() return true end,
          }),
        },
        scroll = {
          enable = true,
          timing = animate.gen_timing.exponential({ duration = 200, unit = 'total' }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll) 
              if type(total_scroll) == "table" then return true end
              return total_scroll > 1 
            end,
          }),
        },
        resize = {
          enable = true,
          timing = animate.gen_timing.exponential({ duration = 100, unit = 'total' }),
          subresize = animate.gen_subresize.equal({
            predicate = function(total_resize) 
              if type(total_resize) == "table" then return true end
              return total_resize > 1 
            end,
          }),
        },
        open = {
          enable = true,
          timing = animate.gen_timing.exponential({ duration = 200, unit = 'total' }),
          winconfig = animate.gen_winconfig.wipe({ direction = 'from_edge' }),
          winblend = animate.gen_winblend.linear({ from = 80, to = 0 }),
        },
        close = {
          enable = true,
          timing = animate.gen_timing.exponential({ duration = 150, unit = 'total' }),
          winconfig = animate.gen_winconfig.wipe({ direction = 'to_edge' }),
          winblend = animate.gen_winblend.linear({ from = 0, to = 80 }),
        },
      }
    end,
  },

  -- Rainbow delimiters with animation
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }

      -- Beautiful rainbow colors
      vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#f7768e' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#e0af68' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#7aa2f7' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#ff9e64' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#9ece6a' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#bb9af7' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#7dcfff' })
    end,
  },

  -- Beautiful scrollbar with git integration
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    opts = {
      show = true,
      show_in_active_only = false,
      set_highlights = true,
      folds = 1000,
      max_lines = false,
      hide_if_all_visible = false,
      throttle_ms = 100,
      handle = {
        text = " ",
        color = "#7aa2f7",
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true,
      },
      marks = {
        Cursor = {
          text = "•",
          priority = 0,
          gui = nil,
          color = "#bb9af7",
          cterm = nil,
          color_nr = nil,
          highlight = "Normal",
        },
        Search = {
          text = { "=", "=" },
          priority = 1,
          gui = nil,
          color = "#e0af68",
          cterm = nil,
          color_nr = nil,
          highlight = "Search",
        },
        Error = {
          text = { "!", "!" },
          priority = 2,
          gui = nil,
          color = "#f7768e",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "!", "!" },
          priority = 3,
          gui = nil,
          color = "#e0af68",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "!", "!" },
          priority = 4,
          gui = nil,
          color = "#7aa2f7",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "!", "!" },
          priority = 5,
          gui = nil,
          color = "#1abc9c",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "!", "!" },
          priority = 6,
          gui = nil,
          color = "#bb9af7",
          cterm = nil,
          color_nr = nil,
          highlight = "Normal",
        },
        GitAdd = {
          text = "│",
          priority = 7,
          gui = nil,
          color = "#9ece6a",
          cterm = nil,
          color_nr = nil,
          highlight = "GitSignsAdd",
        },
        GitChange = {
          text = "│",
          priority = 7,
          gui = nil,
          color = "#e0af68",
          cterm = nil,
          color_nr = nil,
          highlight = "GitSignsChange",
        },
        GitDelete = {
          text = "▁",
          priority = 7,
          gui = nil,
          color = "#f7768e",
          cterm = nil,
          color_nr = nil,
          highlight = "GitSignsDelete",
        },
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "alpha", "dashboard", "neo-tree", "lazy", "mason", "prompt", "TelescopePrompt",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "BufWinLeave",
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = false,
        ale = false,
      },
    },
    config = function(_, opts)
      require("scrollbar").setup(opts)
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- Beautiful highlight on yank
  {
    "machakann/vim-highlightedyank",
    lazy = false,
    config = function()
      vim.g.highlightedyank_highlight_duration = 200
      vim.api.nvim_set_hl(0, 'HighlightedyankRegion', {
        bg = '#7aa2f7',
        fg = '#1a1b26',
        bold = true
      })
    end,
  },

  -- Beautiful terminal với floating window
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 20,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        row = math.floor(vim.o.lines * 0.1),
        col = math.floor(vim.o.columns * 0.1),
      },
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Beautiful terminal keymaps
      local Terminal = require('toggleterm.terminal').Terminal

      -- Floating terminal
      local float_term = Terminal:new({
        direction = "float",
        float_opts = {
          border = "double",
          winblend = 20,
        }
      })

      -- Lazygit integration
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 10,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _G.lazygit_toggle()
        lazygit:toggle()
      end

      function _G.float_term_toggle()
        float_term:toggle()
      end

      -- Beautiful key mappings
      vim.keymap.set("n", "<leader>tf", "<cmd>lua float_term_toggle()<CR>", { desc = "🌊 Floating Terminal" })
      vim.keymap.set("n", "<leader>tg", "<cmd>lua lazygit_toggle()<CR>", { desc = " Lazygit" })
    end,
  },

  -- Beautiful startup screen animations
  {
    "folke/drop.nvim",
    lazy = false,
    opts = {
      theme = "leaves",
      max = 40,
      interval = 150,
      screensaver = 1000 * 60 * 5, -- 5 minutes
      filetypes = { "alpha", "dashboard", "neo-tree", "lazy" },
    },
  },
}