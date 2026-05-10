-- ============================================
-- NOTIFICATIONS & UI FEEDBACK - Beautiful notifications
-- Gorgeous notification system and UI feedback
-- ============================================

return {
  -- Beautiful animated notifications
  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 950,
    opts = {
      background_colour = "#1a1b26",
      fps = 60,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      level = 2,
      minimum_width = 50,
      render = "wrapped-compact",
      stages = "fade",
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T"
      },
      timeout = 3000,
      top_down = true,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      -- Beautiful notification replacements
      vim.notify = require("notify")
    end,
    config = function(_, opts)
      require("notify").setup(opts)

      -- Beautiful colors for notifications
      vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#f7768e", bold = true })
      vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = "#c0caf5" })

      vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#e0af68", bold = true })
      vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = "#c0caf5" })

      vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "#c0caf5" })

      vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#565f89" })
      vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = "#565f89" })
      vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#565f89", bold = true })
      vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = "#c0caf5" })

      vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#bb9af7" })
      vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = "#bb9af7" })
      vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#bb9af7", bold = true })
      vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = "#c0caf5" })

      -- Background
      vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#1a1b26" })

      -- Beautiful startup notification
      vim.defer_fn(function()
        vim.notify("🌟 Welcome to SuperVim Ultra Beautiful Edition! 🌟", "info", {
          title = "✨ SuperVim Loaded",
          icon = "🚀",
          timeout = 4000,
        })
      end, 1000)
    end,
  },

  -- Beautiful floating input and select
  {
    "stevearc/dressing.nvim",
    lazy = false,
    priority = 900,
    opts = {
      input = {
        enabled = true,
        default_prompt = "➤ ",
        title_pos = "center",
        insert_only = true,
        start_in_insert = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          winblend = 20,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          sidescrolloff = 0,
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end,
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
        telescope = {
          winblend = 20,
          layout_config = {
            width = 0.8,
            height = 0.8,
          },
        },
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },
        fzf_lua = {
          winopts = {
            height = 0.5,
            width = 0.5,
          },
        },
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded",
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 20,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },
        builtin = {
          show_numbers = true,
          border = "rounded",
          relative = "editor",
          buf_options = {},
          win_options = {
            winblend = 20,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            cursorline = true,
            cursorlineopt = "both",
          },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
        },
        format_item_override = {},
        get_config = nil,
      },
    },
    config = function(_, opts)
      require("dressing").setup(opts)

      -- Beautiful highlights for input/select windows
      vim.api.nvim_set_hl(0, "DressingInputNormal", { bg = "#1a1b26" })
      vim.api.nvim_set_hl(0, "DressingInputBorder", { fg = "#7aa2f7", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DressingInputTitle", { fg = "#7aa2f7", bg = "NONE", bold = true })

      vim.api.nvim_set_hl(0, "DressingSelectNormal", { bg = "#1a1b26" })
      vim.api.nvim_set_hl(0, "DressingSelectBorder", { fg = "#7aa2f7", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DressingSelectTitle", { fg = "#7aa2f7", bg = "NONE", bold = true })
    end,
  },

  -- Beautiful command palette (if you want to add it later)
  {
    "folke/noice.nvim",
    enabled = false, -- Disable by default as it can be overwhelming
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- Beautiful floating command line
  {
    "VonHeikemen/fine-cmdline.nvim",
    enabled = false, -- Optional enhancement
    dependencies = {
      "MunifTanjim/nui.nvim"
    },
    cmd = "FineCmdline",
    opts = {
      cmdline = {
        enable_keymaps = true,
        smart_history = true,
        prompt = "❯ ",
      },
      popup = {
        position = {
          row = "10%",
          col = "50%",
        },
        size = {
          width = "60%",
        },
        border = {
          style = "rounded",
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          winblend = 20,
        },
      },
    },
    keys = {
      { ":", "<cmd>FineCmdline<CR>", desc = "Fine cmdline" },
    },
  },

  -- Beautiful vim messages enhancement
  {
    "folke/messages.nvim",
    enabled = false, -- Optional feature
    event = "VeryLazy",
    opts = {
      command_name = "Messages",
    },
    keys = {
      { "<leader>um", "<cmd>Messages<cr>", desc = "Messages" },
    },
  },
}