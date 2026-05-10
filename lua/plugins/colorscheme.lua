-- ============================================
-- COLORSCHEMES - The most beautiful themes
-- Tokyo Night and other stunning themes
-- ============================================

return {
  -- Tokyo Night - The stunning flagship theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night", -- storm, moon, night, day
      light_style = "day",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "vista_kind", "terminal", "packer" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = true,
      use_background = true,
      on_colors = function(colors)
        -- Make colors even more beautiful
        colors.bg = "#1a1b26"
        colors.bg_dark = "#16161e"
        colors.bg_float = "#16161e"
        colors.bg_popup = "#16161e"
        colors.bg_sidebar = "#16161e"
        colors.bg_statusline = "#16161e"
        colors.fg_gutter = "#3b4261"
        colors.border = "#1f2335"

        -- Enhanced accent colors
        colors.blue = "#7aa2f7"
        colors.blue1 = "#2ac3de"
        colors.blue2 = "#0db9d7"
        colors.blue5 = "#89ddff"
        colors.blue6 = "#b4f9f8"
        colors.blue7 = "#394b70"
        colors.cyan = "#7dcfff"
        colors.green = "#9ece6a"
        colors.green1 = "#73daca"
        colors.green2 = "#41a6b5"
        colors.magenta = "#bb9af7"
        colors.magenta2 = "#ff007c"
        colors.orange = "#ff9e64"
        colors.purple = "#9d7cd8"
        colors.red = "#f7768e"
        colors.red1 = "#db4b4b"
        colors.teal = "#1abc9c"
        colors.yellow = "#e0af68"

        -- Special UI colors
        colors.git = {
          add = "#449dab",
          change = "#6183bb",
          delete = "#914c54"
        }
      end,
      on_highlights = function(hl, colors)
        -- Custom highlights for ultra beauty
        hl.CursorLine = { bg = "NONE" }
        hl.CursorLineNr = { fg = colors.orange, bold = true }
        hl.LineNr = { fg = colors.fg_gutter }
        hl.SignColumn = { bg = "NONE" }
        hl.StatusLine = { bg = "NONE" }
        hl.StatusLineNC = { bg = "NONE" }
        hl.TabLine = { bg = "NONE" }
        hl.TabLineFill = { bg = "NONE" }
        hl.TabLineSel = { bg = "NONE" }
        hl.WinBar = { bg = "NONE" }
        hl.WinBarNC = { bg = "NONE" }

        -- Floating windows
        hl.NormalFloat = { bg = "NONE" }
        hl.FloatBorder = { fg = colors.border, bg = "NONE" }
        hl.FloatTitle = { fg = colors.blue, bg = "NONE", bold = true }

        -- Tree-sitter highlights
        hl["@keyword"] = { fg = colors.purple, italic = true }
        hl["@keyword.function"] = { fg = colors.magenta, italic = true }
        hl["@keyword.return"] = { fg = colors.red, italic = true }
        hl["@function"] = { fg = colors.blue, bold = true }
        hl["@function.call"] = { fg = colors.blue }
        hl["@method"] = { fg = colors.blue, bold = true }
        hl["@method.call"] = { fg = colors.blue }
        hl["@constructor"] = { fg = colors.yellow }
        hl["@parameter"] = { fg = colors.orange, italic = true }
        hl["@variable"] = { fg = colors.fg }
        hl["@variable.builtin"] = { fg = colors.red, italic = true }
        hl["@constant"] = { fg = colors.orange }
        hl["@constant.builtin"] = { fg = colors.orange, bold = true }
        hl["@string"] = { fg = colors.green }
        hl["@string.escape"] = { fg = colors.cyan, bold = true }
        hl["@type"] = { fg = colors.yellow }
        hl["@type.builtin"] = { fg = colors.yellow, italic = true }
        hl["@namespace"] = { fg = colors.cyan }
        hl["@property"] = { fg = colors.green1 }
        hl["@attribute"] = { fg = colors.yellow }
        hl["@comment"] = { fg = colors.comment, italic = true }

        -- Enhanced LSP highlights
        hl.LspReferenceText = { bg = colors.fg_gutter }
        hl.LspReferenceRead = { bg = colors.fg_gutter }
        hl.LspReferenceWrite = { bg = colors.fg_gutter }

        -- Enhanced diagnostic highlights
        hl.DiagnosticError = { fg = colors.red }
        hl.DiagnosticWarn = { fg = colors.yellow }
        hl.DiagnosticInfo = { fg = colors.blue }
        hl.DiagnosticHint = { fg = colors.teal }
        hl.DiagnosticVirtualTextError = { fg = colors.red, bg = "NONE", italic = true }
        hl.DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = "NONE", italic = true }
        hl.DiagnosticVirtualTextInfo = { fg = colors.blue, bg = "NONE", italic = true }
        hl.DiagnosticVirtualTextHint = { fg = colors.teal, bg = "NONE", italic = true }

        -- Git signs
        hl.GitSignsAdd = { fg = colors.git.add }
        hl.GitSignsChange = { fg = colors.git.change }
        hl.GitSignsDelete = { fg = colors.git.delete }

        -- Telescope
        hl.TelescopeNormal = { bg = "NONE" }
        hl.TelescopeBorder = { fg = colors.border, bg = "NONE" }
        hl.TelescopePromptBorder = { fg = colors.orange, bg = "NONE" }
        hl.TelescopePromptTitle = { fg = colors.orange, bg = "NONE", bold = true }
        hl.TelescopeResultsTitle = { fg = colors.blue, bg = "NONE", bold = true }
        hl.TelescopePreviewTitle = { fg = colors.green, bg = "NONE", bold = true }
        hl.TelescopeSelection = { bg = colors.bg_highlight }
        hl.TelescopeMatching = { fg = colors.blue, bold = true }

        -- Alpha dashboard
        hl.AlphaHeader = { fg = colors.blue }
        hl.AlphaButtons = { fg = colors.fg }
        hl.AlphaShortcut = { fg = colors.green }
        hl.AlphaFooter = { fg = colors.comment, italic = true }

        -- Bufferline
        hl.BufferLineBackground = { bg = "NONE" }
        hl.BufferLineFill = { bg = "NONE" }
        hl.BufferLineTab = { bg = "NONE" }
        hl.BufferLineTabSelected = { bg = "NONE" }
        hl.BufferLineTabClose = { bg = "NONE" }
        hl.BufferLineIndicatorSelected = { fg = colors.blue, bg = "NONE" }

        -- Neo-tree
        hl.NeoTreeNormal = { bg = "NONE" }
        hl.NeoTreeNormalNC = { bg = "NONE" }
        hl.NeoTreeWinSeparator = { fg = colors.border, bg = "NONE" }

        -- Which-key
        hl.WhichKeyFloat = { bg = "NONE" }
        hl.WhichKeyBorder = { fg = colors.border, bg = "NONE" }

        -- Notify
        hl.NotifyBackground = { bg = colors.bg }
        hl.NotifyERRORBorder = { fg = colors.red }
        hl.NotifyWARNBorder = { fg = colors.yellow }
        hl.NotifyINFOBorder = { fg = colors.blue }
        hl.NotifyDEBUGBorder = { fg = colors.comment }
        hl.NotifyTRACEBorder = { fg = colors.purple }

        -- Mason
        hl.MasonNormal = { bg = "NONE" }
        hl.MasonHeader = { fg = colors.blue, bg = "NONE", bold = true }
        hl.MasonHighlight = { fg = colors.blue }
        hl.MasonHighlightBlock = { fg = colors.bg, bg = colors.blue }
        hl.MasonMuted = { fg = colors.comment }

        -- Trouble
        hl.TroubleNormal = { bg = "NONE" }

        -- Terminal
        hl.TerminalNormal = { bg = "NONE" }
        hl.TerminalNormalNC = { bg = "NONE" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")

      -- Additional beautiful customizations
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3b4261", bg = "NONE" })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = "#3b4261", bg = "NONE" })

      -- Make the editor look stunning
      vim.opt.termguicolors = true
      vim.opt.background = "dark"

      -- Enable transparency
      if vim.g.transparent_enabled then
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
      end
    end,
  },

  -- Alternative stunning themes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 900,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = false,
        telescope = {
          enabled = true,
          style = "nvchad"
        },
        alpha = true,
        dashboard = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        mason = true,
        neotree = true,
        lsp_trouble = true,
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        dap = {
          enabled = true,
          enable_ui = true,
        },
      },
    },
  },

  -- Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    priority = 800,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_current_word = "grey background"
    end,
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 700,
    opts = {
      variant = "auto",
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = true,
      disable_float_background = true,
      disable_italics = false,
      groups = {
        background = "base",
        background_nc = "_experimental_nc",
        panel = "surface",
        panel_nc = "base",
        border = "highlight_med",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",
        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",
        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
      },
      highlight_groups = {
        TelescopeBorder = { fg = "highlight_high", bg = "none" },
        TelescopeNormal = { bg = "none" },
        TelescopePromptNormal = { bg = "base" },
        TelescopeResultsNormal = { fg = "subtle", bg = "none" },
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
      },
    },
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    priority = 600,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = { bold = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus"
      },
    },
  },
}