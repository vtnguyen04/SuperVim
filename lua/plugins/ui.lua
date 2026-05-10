-- ============================================
-- UI PLUGINS - Interface components
-- Status line, bufferline, notifications
-- ============================================

return {
  -- Transparent background với blur effect
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      groups = {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLineNr', 'EndOfBuffer',
      },
      extra_groups = {
        "NormalFloat",
        "FloatBorder",
        "Pmenu",
        "PmenuSel",
        "PmenuSbar",
        "PmenuThumb",
      },
      exclude_groups = {},
    },
    config = function(_, opts)
      require("transparent").setup(opts)
      require("transparent").clear_prefix("BufferLine")
      require("transparent").clear_prefix("NeoTree")
      require("transparent").clear_prefix("lualine")
    end,
  },

  -- Animated và beautiful bufferline
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    priority = 900,
    opts = {
      options = {
        mode = "buffers",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        indicator = {
          icon = '┃', -- Thicker vertical bar for better visibility
          style = 'icon', -- Use icon style instead of hard-to-see underline
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 25,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "slant", -- slant | slope | thick | thin
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = 'insert_after_current',
        offsets = {
          {
            filetype = "neo-tree",
            text = "🌟 File Explorer",
            highlight = "Directory",
            text_align = "center",
            separator = true
          }
        },
      },
      highlights = {
        fill = {
          bg = "NONE",
        },
        background = {
          bg = "NONE",
        },
        buffer_selected = {
          fg = "#7aa2f7",
          bg = "NONE",
          bold = true,
          italic = true,
        },
        buffer_visible = {
          fg = "#9aa5ce",
          bg = "NONE",
        },
        close_button = {
          fg = "#9aa5ce",
          bg = "NONE",
        },
        close_button_visible = {
          fg = "#9aa5ce",
          bg = "NONE",
        },
        close_button_selected = {
          fg = "#f7768e",
          bg = "NONE",
        },
        indicator_selected = {
          fg = "#7aa2f7",
          bg = "NONE",
        },
        modified = {
          fg = "#e0af68",
          bg = "NONE",
        },
        modified_visible = {
          fg = "#e0af68",
          bg = "NONE",
        },
        modified_selected = {
          fg = "#e0af68",
          bg = "NONE",
        },
        duplicate_selected = {
          fg = "#7aa2f7",
          bg = "NONE",
          italic = true,
        },
        duplicate_visible = {
          fg = "#9aa5ce",
          bg = "NONE",
          italic = true,
        },
        duplicate = {
          fg = "#9aa5ce",
          bg = "NONE",
          italic = true,
        },
        separator = {
          fg = "#3b4261",
          bg = "NONE",
        },
        separator_selected = {
          fg = "#3b4261",
          bg = "NONE",
        },
        separator_visible = {
          fg = "#3b4261",
          bg = "NONE",
        },
        tab = {
          fg = "#9aa5ce",
          bg = "NONE",
        },
        tab_selected = {
          fg = "#7aa2f7",
          bg = "NONE",
        },
        tab_close = {
          fg = "#f7768e",
          bg = "NONE",
        },
      },
    },
  },

  -- Beautiful status line với glassmorphism
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    priority = 800,
    opts = {
      options = {
        theme = {
          normal = {
            a = { fg = '#1a1b26', bg = '#7aa2f7', gui = 'bold' },
            b = { fg = '#7aa2f7', bg = 'NONE' },
            c = { fg = '#9aa5ce', bg = 'NONE' },
          },
          insert = {
            a = { fg = '#1a1b26', bg = '#9ece6a', gui = 'bold' },
            b = { fg = '#9ece6a', bg = 'NONE' },
          },
          visual = {
            a = { fg = '#1a1b26', bg = '#bb9af7', gui = 'bold' },
            b = { fg = '#bb9af7', bg = 'NONE' },
          },
          replace = {
            a = { fg = '#1a1b26', bg = '#f7768e', gui = 'bold' },
            b = { fg = '#f7768e', bg = 'NONE' },
          },
          command = {
            a = { fg = '#1a1b26', bg = '#e0af68', gui = 'bold' },
            b = { fg = '#e0af68', bg = 'NONE' },
          },
          inactive = {
            a = { fg = '#9aa5ce', bg = 'NONE' },
            b = { fg = '#9aa5ce', bg = 'NONE' },
            c = { fg = '#9aa5ce', bg = 'NONE' },
          },
        },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard" },
          winbar = {},
        },
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return ' ' .. str:sub(1,1) .. ' '
            end,
            separator = { right = '' },
          }
        },
        lualine_b = {
          {
            'branch',
            icon = '',
            color = { fg = '#7aa2f7' },
          },
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' '
            },
            diff_color = {
              added = { fg = '#9ece6a' },
              modified = { fg = '#e0af68' },
              removed = { fg = '#f7768e' },
            },
          }
        },
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' '
            },
            diagnostics_color = {
              error = { fg = '#f7768e' },
              warn = { fg = '#e0af68' },
              info = { fg = '#7aa2f7' },
              hint = { fg = '#1abc9c' },
            },
          },
          {
            'filename',
            file_status = true,
            newfile_status = true,
            path = 1,
            symbols = {
              modified = ' ●',
              readonly = ' ',
              unnamed = ' [No Name]',
              newfile = ' [New]',
            },
            color = { fg = '#9aa5ce' },
          }
        },
        lualine_x = {
          {
            'encoding',
            fmt = string.upper,
            color = { fg = '#9aa5ce' },
          },
          {
            'fileformat',
            symbols = {
              unix = '',
              dos = '',
              mac = '',
            },
            color = { fg = '#9aa5ce' },
          },
          {
            'filetype',
            colored = true,
            icon_only = false,
            color = { fg = '#7aa2f7' },
          }
        },
        lualine_y = {
          {
            'progress',
            color = { fg = '#bb9af7' },
          }
        },
        lualine_z = {
          {
            'location',
            separator = { left = '' },
          }
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      extensions = { 'neo-tree', 'lazy', 'trouble', 'mason', 'fzf' }
    },
  },


  -- Glassmorphism floating windows
  {
    "stevearc/dressing.nvim",
    lazy = false,
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
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
        telescope = {
          winblend = 20,
          layout_config = {
            width = 0.5,
            height = 0.4,
          },
        },
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },
        fzf_lua = {},
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
  },

  -- Beautiful dashboard
  {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 1100,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Ultra beautiful ASCII art
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[  ███████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[  ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██║████╗ ████║ ]],
        [[  ███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║██║██╔████╔██║ ]],
        [[  ╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[  ███████║╚██████╔╝██║     ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[  ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                                       ]],
        [[                        ✨ ULTRA BEAUTIFUL EDITION ✨               ]],
        [[                                                                       ]],
      }

      -- Beautiful buttons with icons
      dashboard.section.buttons.val = {
        dashboard.button("f", "🔍  Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", "📝  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "🕘  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "🔎  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "⚙️   Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("p", "📦  Plugins", ":Lazy <CR>"),
        dashboard.button("h", "💡  Health check", ":checkhealth <CR>"),
        dashboard.button("q", "🚪  Quit Neovim", ":qa<CR>"),
      }

      local function footer()
        return "🌟 SuperVim Ultra Beautiful - The Most Stunning Neovim Experience 🌟"
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      -- Modernize shortcut highlights (No more underlines)
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#bb9af7", bold = true })

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  },

  -- Beautiful indent guides with animation
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = false,
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
        highlight = highlight,
        smart_indent_cap = true,
        priority = 2,
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
        char = "│",
        highlight = "IblScope",
        priority = 1024,
        include = {
          node_type = {
            ["*"] = { "*" },
          },
        },
        exclude = {
          language = {},
          node_type = {
            ["*"] = {
              "source_file",
              "program",
            },
            python = {
              "module",
            },
          },
        },
      },
      exclude = {
        filetypes = {
          "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason",
          "notify", "toggleterm", "lazyterm", "lspinfo", "checkhealth", "TelescopePrompt"
        },
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)

      -- Beautiful colors
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4261" })
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" })
      end)
    end,
  },

}