-- ============================================
-- ENHANCED UI PLUGINS - Hyprland Style Interface
-- Beautiful tabs, layouts, and visual effects
-- ============================================

return {
  -- Advanced Bufferline with Hyprland-style tabs
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    priority = 900,
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "slant", -- "slant" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
        -- Custom styling for Hyprland look
        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, { text = "  " .. error, fg = "#f7768e" })
            end

            if warning ~= 0 then
              table.insert(result, { text = "  " .. warning, fg = "#e0af68" })
            end

            if hint ~= 0 then
              table.insert(result, { text = "  " .. hint, fg = "#1abc9c" })
            end

            if info ~= 0 then
              table.insert(result, { text = "  " .. info, fg = "#7aa2f7" })
            end
            return result
          end,
        },
      },
      highlights = {
        fill = {
          bg = "#1a1b26",
        },
        background = {
          bg = "#24283b",
          fg = "#565f89",
        },
        tab = {
          bg = "#24283b",
          fg = "#565f89",
        },
        tab_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
          bold = true,
        },
        tab_separator = {
          bg = "#24283b",
          fg = "#1a1b26",
        },
        tab_separator_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        tab_close = {
          bg = "#24283b",
          fg = "#565f89",
        },
        close_button = {
          bg = "#24283b",
          fg = "#565f89",
        },
        close_button_visible = {
          bg = "#33467c",
          fg = "#c0caf5",
        },
        close_button_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        buffer_visible = {
          bg = "#33467c",
          fg = "#c0caf5",
        },
        buffer_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
          bold = true,
          italic = false,
        },
        numbers = {
          bg = "#24283b",
          fg = "#565f89",
        },
        numbers_visible = {
          bg = "#33467c",
          fg = "#c0caf5",
        },
        numbers_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
          bold = true,
        },
        diagnostic = {
          bg = "#24283b",
          fg = "#565f89",
        },
        diagnostic_visible = {
          bg = "#33467c",
          fg = "#c0caf5",
        },
        diagnostic_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
          bold = true,
        },
        hint = {
          bg = "#24283b",
          fg = "#1abc9c",
        },
        hint_visible = {
          bg = "#33467c",
          fg = "#1abc9c",
        },
        hint_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        hint_diagnostic = {
          bg = "#24283b",
          fg = "#1abc9c",
        },
        hint_diagnostic_visible = {
          bg = "#33467c",
          fg = "#1abc9c",
        },
        hint_diagnostic_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        info = {
          bg = "#24283b",
          fg = "#7aa2f7",
        },
        info_visible = {
          bg = "#33467c",
          fg = "#7aa2f7",
        },
        info_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        info_diagnostic = {
          bg = "#24283b",
          fg = "#7aa2f7",
        },
        info_diagnostic_visible = {
          bg = "#33467c",
          fg = "#7aa2f7",
        },
        info_diagnostic_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        warning = {
          bg = "#24283b",
          fg = "#e0af68",
        },
        warning_visible = {
          bg = "#33467c",
          fg = "#e0af68",
        },
        warning_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        warning_diagnostic = {
          bg = "#24283b",
          fg = "#e0af68",
        },
        warning_diagnostic_visible = {
          bg = "#33467c",
          fg = "#e0af68",
        },
        warning_diagnostic_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        error = {
          bg = "#24283b",
          fg = "#f7768e",
        },
        error_visible = {
          bg = "#33467c",
          fg = "#f7768e",
        },
        error_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        error_diagnostic = {
          bg = "#24283b",
          fg = "#f7768e",
        },
        error_diagnostic_visible = {
          bg = "#33467c",
          fg = "#f7768e",
        },
        error_diagnostic_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        modified = {
          bg = "#24283b",
          fg = "#e0af68",
        },
        modified_visible = {
          bg = "#33467c",
          fg = "#e0af68",
        },
        modified_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        duplicate_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
          italic = true,
        },
        duplicate_visible = {
          bg = "#33467c",
          fg = "#c0caf5",
          italic = true,
        },
        duplicate = {
          bg = "#24283b",
          fg = "#565f89",
          italic = true,
        },
        separator_selected = {
          bg = "#7aa2f7",
          fg = "#1a1b26",
        },
        separator_visible = {
          bg = "#33467c",
          fg = "#1a1b26",
        },
        separator = {
          bg = "#24283b",
          fg = "#1a1b26",
        },
        indicator_selected = {
          bg = "#7aa2f7",
          fg = "#7aa2f7",
        },
        indicator_visible = {
          bg = "#33467c",
          fg = "#7aa2f7",
        },
        pick_selected = {
          bg = "#7aa2f7",
          fg = "#f7768e",
          bold = true,
          italic = true,
        },
        pick_visible = {
          bg = "#33467c",
          fg = "#f7768e",
          bold = true,
          italic = true,
        },
        pick = {
          bg = "#24283b",
          fg = "#f7768e",
          bold = true,
          italic = true,
        },
        offset_separator = {
          bg = "#1a1b26",
          fg = "#1a1b26",
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- Enhanced floating terminal with beautiful design
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = { "n", "t" } },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "rounded",
        winblend = 10,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Custom terminal configurations
      local Terminal = require("toggleterm.terminal").Terminal

      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "rounded",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      -- Node.js REPL
      local node = Terminal:new({
        cmd = "node",
        direction = "float",
        float_opts = {
          border = "rounded",
        },
      })

      -- Python REPL
      local python = Terminal:new({
        cmd = "python3",
        direction = "float",
        float_opts = {
          border = "rounded",
        },
      })

      -- Custom keybindings
      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { desc = "LazyGit", noremap = true, silent = true })

      vim.keymap.set("n", "<leader>tn", function()
        node:toggle()
      end, { desc = "Node REPL", noremap = true, silent = true })

      vim.keymap.set("n", "<leader>tp", function()
        python:toggle()
      end, { desc = "Python REPL", noremap = true, silent = true })

      -- Terminal mode mappings
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },

  -- Beautiful notifications with animations
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      background_colour = "#1a1b26",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "compact",
      stages = "fade_in_slide_out",
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T",
      },
      top_down = true,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  -- Window picker for beautiful navigation
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    lazy = false,
    version = "2.*",
    opts = {
      hint = "floating-big-letter",
      selection_chars = "FJDKSLA;CMRUEIWOQP",
      picker_config = {
        statusline_winbar_picker = {
          selection_display = function(char, windowid)
            return "%=" .. char .. "%="
          end,
          use_winbar = "never",
        },
        floating_big_letter = {
          font = "ansi-shadow",
        },
      },
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify" },
          buftype = { "terminal", "quickfix" },
        },
      },
      highlights = {
        statusline = {
          focused = {
            fg = "#1a1b26",
            bg = "#7aa2f7",
            bold = true,
          },
          unfocused = {
            fg = "#c0caf5",
            bg = "#565f89",
            bold = true,
          },
        },
        winbar = {
          focused = {
            fg = "#1a1b26",
            bg = "#7aa2f7",
            bold = true,
          },
          unfocused = {
            fg = "#c0caf5",
            bg = "#565f89",
            bold = true,
          },
        },
      },
    },
    keys = {
      {
        "<leader>wp",
        function()
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "Pick a window",
      },
    },
  },
}