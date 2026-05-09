-- ============================================
-- VISUAL EFFECTS - Beautiful animations and eye candy
-- Making SuperVim look absolutely stunning
-- ============================================

return {
  -- Animated indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        injected_languages = false,
        highlight = { "Function", "Label" },
        priority = 500,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
    config = function(_, opts)
      require("ibl").setup(opts)

      -- Tokyo Night colors for indent guides
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4261" })
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" })
      end)
    end,
  },

  -- Beautiful highlight on yank
  {
    "machakann/vim-highlightedyank",
    event = "VeryLazy",
    config = function()
      vim.g.highlightedyank_highlight_duration = 300
      vim.api.nvim_set_hl(0, "HighlightedyankRegion", { bg = "#7aa2f7", fg = "#1a1b26" })
    end,
  },

  -- Colorful brackets and parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }

      -- Tokyo Night colors for rainbow delimiters
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#ff9e64" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#bb9af7" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#73daca" })
    end,
  },

  -- Animated cursor line
  {
    "yamatsum/nvim-cursorline",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      },
    },
  },

  -- Beautiful color column
  {
    "lukas-reineke/virt-column.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "┃",
      virtcolumn = "80,120",
      highlight = "NonText",
    },
    config = function(_, opts)
      require("virt-column").setup(opts)
      vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#3b4261" })
    end,
  },

  -- Smooth cursor animations
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smoothcursor").setup({
        type = "default",
        cursor = "",
        texthl = "SmoothCursor",
        linehl = nil,
        fancy = {
          enable = true,
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "󰝥", texthl = "SmoothCursorRed" },
            { cursor = "󰝥", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" },
        },
        matrix = {
          head = {
            cursor = require("smoothcursor.matrix_chars")[math.random(1, #require("smoothcursor.matrix_chars"))],
            texthl = "SmoothCursor",
            linehl = nil,
          },
          body = {
            length = 6,
            cursor = require("smoothcursor.matrix_chars")[math.random(1, #require("smoothcursor.matrix_chars"))],
            texthl = "SmoothCursorGreen",
          },
          tail = {
            cursor = nil,
            texthl = "SmoothCursor",
          },
          unstop = false,
        },
        autostart = true,
        always_redraw = true,
        flyin_effect = nil,
        speed = 25,
        intervals = 35,
        priority = 10,
        timeout = 3000,
        threshold = 3,
        disable_float_win = false,
        enabled_filetypes = nil,
        disabled_filetypes = { "TelescopePrompt", "NvimTree", "neo-tree" },
      })

      -- Tokyo Night colors for smooth cursor
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "SmoothCursorRed", { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "SmoothCursorOrange", { fg = "#ff9e64" })
      vim.api.nvim_set_hl(0, "SmoothCursorYellow", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "SmoothCursorGreen", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "SmoothCursorAqua", { fg = "#73daca" })
      vim.api.nvim_set_hl(0, "SmoothCursorBlue", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "SmoothCursorPurple", { fg = "#bb9af7" })
    end,
  },

  -- Beautiful startup screen with animations
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = function()
      return vim.fn.argc(-1) == 0
    end,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
      ██████╗ ██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗
      ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██║████╗ ████║
      ███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║██║██╔████╔██║
      ╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
      ███████║╚██████╔╝██║     ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")

      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8

      return dashboard
    end,
    config = function(_, dashboard)
      -- Close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      -- Set colors
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#c0caf5" })
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#565f89", italic = true })
    end,
  },

  -- Beautiful scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show = true,
      show_in_active_only = false,
      set_highlights = false,
      folds = 1000,
      max_lines = false,
      hide_if_all_visible = false,
      throttle_ms = 100,
      handle = {
        text = " ",
        blend = 30,
        color = "#7aa2f7",
        color_nr = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true,
      },
      marks = {
        Cursor = {
          text = "•",
          priority = 0,
          gui = nil,
          color = "#7aa2f7",
          cterm = nil,
          color_nr = nil,
          highlight = "Normal",
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          gui = nil,
          color = "#e0af68",
          cterm = nil,
          color_nr = nil,
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          priority = 2,
          gui = nil,
          color = "#f7768e",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 3,
          gui = nil,
          color = "#e0af68",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 4,
          gui = nil,
          color = "#7aa2f7",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 5,
          gui = nil,
          color = "#73daca",
          cterm = nil,
          color_nr = nil,
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 6,
          gui = nil,
          color = "#bb9af7",
          cterm = nil,
          color_nr = nil,
          highlight = "Normal",
        },
        GitAdd = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = "#9ece6a",
          cterm = nil,
          color_nr = nil,
          highlight = "GitSignsAdd",
        },
        GitChange = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = "#7aa2f7",
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
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
        "alpha",
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
  },

  -- Animated folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      require("ufo").setup(opts)
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    end,
  },

  -- Beautiful winbar with drop shadows
  {
    "b0o/incline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPre", "BufNewFile" },
    priority = 1200,
    config = function()
      local colors = {
        bg = "#1a1b26",
        fg = "#c0caf5",
        blue = "#7aa2f7",
        green = "#9ece6a",
        red = "#f7768e",
        yellow = "#e0af68",
        purple = "#bb9af7",
        cyan = "#73daca",
        grey = "#565f89",
      }

      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 1 },
        },
        hide = {
          cursorline = false,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
}