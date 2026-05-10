-- ============================================
-- GIT PLUGINS - Git integration
-- ============================================

return {
  -- Gitsigns - Git decorations
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>ub", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Diff this ~" })
        map("n", "<leader>ud", gs.toggle_deleted, { desc = "Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Diffview - Enhanced diff viewing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView File History" },
    },
    opts = {
      diff_binaries = false,
      enhanced_diff_hl = false,
      git_cmd = { "git" },
      use_icons = true,
      show_help_hints = true,
      watch_index = true,
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {},
        },
      },
      commit_log_panel = {
        win_config = {
          win_opts = {},
        },
      },
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {},
      keymaps = {
        disable_defaults = false,
        view = {
          {
            "n",
            "<tab>",
            function()
              require("diffview.actions").select_next_entry()
            end,
            { desc = "Open the diff for the next file" },
          },
          {
            "n",
            "<s-tab>",
            function()
              require("diffview.actions").select_prev_entry()
            end,
            { desc = "Open the diff for the previous file" },
          },
          {
            "n",
            "gf",
            function()
              require("diffview.actions").goto_file()
            end,
            { desc = "Open the file in a new split in the previous tabpage" },
          },
          {
            "n",
            "<C-w><C-f>",
            function()
              require("diffview.actions").goto_file_split()
            end,
            { desc = "Open the file in a new split" },
          },
          {
            "n",
            "<C-w>gf",
            function()
              require("diffview.actions").goto_file_tab()
            end,
            { desc = "Open the file in a new tabpage" },
          },
          {
            "n",
            "<leader>e",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle the file panel." },
          },
        },
        diff1 = {
          { "n", "g?", function() require("diffview.actions").help({ "view", "diff1" }) end, { desc = "Open the help panel" } },
        },
        diff2 = {
          { "n", "g?", function() require("diffview.actions").help({ "view", "diff2" }) end, { desc = "Open the help panel" } },
        },
        diff3 = {
          {
            "n",
            "g?",
            function()
              require("diffview.actions").help({ "view", "diff3" })
            end,
            { desc = "Open the help panel" },
          },
        },
        diff4 = {
          {
            "n",
            "g?",
            function()
              require("diffview.actions").help({ "view", "diff4" })
            end,
            { desc = "Open the help panel" },
          },
        },
        file_panel = {
          {
            "n",
            "j",
            function()
              require("diffview.actions").next_entry()
            end,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "<down>",
            function()
              require("diffview.actions").next_entry()
            end,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "k",
            function()
              require("diffview.actions").prev_entry()
            end,
            { desc = "Bring the cursor to the previous file entry." },
          },
          {
            "n",
            "<up>",
            function()
              require("diffview.actions").prev_entry()
            end,
            { desc = "Bring the cursor to the previous file entry." },
          },
          {
            "n",
            "<cr>",
            function()
              require("diffview.actions").select_entry()
            end,
            { desc = "Open the diff for the selected entry." },
          },
          {
            "n",
            "o",
            function()
              require("diffview.actions").select_entry()
            end,
            { desc = "Open the diff for the selected entry." },
          },
          {
            "n",
            "<2-LeftMouse>",
            function()
              require("diffview.actions").select_entry()
            end,
            { desc = "Open the diff for the selected entry." },
          },
          {
            "n",
            "-",
            function()
              require("diffview.actions").toggle_stage_entry()
            end,
            { desc = "Stage / unstage the selected entry." },
          },
          {
            "n",
            "S",
            function()
              require("diffview.actions").stage_all()
            end,
            { desc = "Stage all entries." },
          },
          {
            "n",
            "U",
            function()
              require("diffview.actions").unstage_all()
            end,
            { desc = "Unstage all entries." },
          },
          {
            "n",
            "X",
            function()
              require("diffview.actions").restore_entry()
            end,
            { desc = "Restore entry to the state on the left side." },
          },
          {
            "n",
            "L",
            function()
              require("diffview.actions").open_commit_log()
            end,
            { desc = "Open the commit log panel." },
          },
          {
            "n",
            "zo",
            function()
              require("diffview.actions").open_fold()
            end,
            { desc = "Expand fold" },
          },
          {
            "n",
            "h",
            function()
              require("diffview.actions").close_fold()
            end,
            { desc = "Collapse fold" },
          },
          {
            "n",
            "zc",
            function()
              require("diffview.actions").close_fold()
            end,
            { desc = "Collapse fold" },
          },
          {
            "n",
            "za",
            function()
              require("diffview.actions").toggle_fold()
            end,
            { desc = "Toggle fold" },
          },
          {
            "n",
            "zR",
            function()
              require("diffview.actions").open_all_folds()
            end,
            { desc = "Expand all folds" },
          },
          {
            "n",
            "zM",
            function()
              require("diffview.actions").close_all_folds()
            end,
            { desc = "Collapse all folds" },
          },
          {
            "n",
            "<c-b>",
            function()
              require("diffview.actions").scroll_view(-0.25)
            end,
            { desc = "Scroll the view up" },
          },
          {
            "n",
            "<c-f>",
            function()
              require("diffview.actions").scroll_view(0.25)
            end,
            { desc = "Scroll the view down" },
          },
          {
            "n",
            "<tab>",
            function()
              require("diffview.actions").select_next_entry()
            end,
            { desc = "Open the diff for the next file" },
          },
          {
            "n",
            "<s-tab>",
            function()
              require("diffview.actions").select_prev_entry()
            end,
            { desc = "Open the diff for the previous file" },
          },
          {
            "n",
            "gf",
            function()
              require("diffview.actions").goto_file()
            end,
            { desc = "Open the file in a new split in the previous tabpage" },
          },
          {
            "n",
            "<C-w><C-f>",
            function()
              require("diffview.actions").goto_file_split()
            end,
            { desc = "Open the file in a new split" },
          },
          {
            "n",
            "<C-w>gf",
            function()
              require("diffview.actions").goto_file_tab()
            end,
            { desc = "Open the file in a new tabpage" },
          },
          {
            "n",
            "i",
            function()
              require("diffview.actions").listing_style()
            end,
            { desc = "Toggle between 'list' and 'tree' views" },
          },
          {
            "n",
            "f",
            function()
              require("diffview.actions").toggle_flatten_dirs()
            end,
            { desc = "Flatten empty subdirectories in tree listing style." },
          },
          {
            "n",
            "R",
            function()
              require("diffview.actions").refresh_files()
            end,
            { desc = "Update stats and entries in the file list." },
          },
          {
            "n",
            "<leader>e",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle the file panel" },
          },
          {
            "n",
            "<leader>b",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle the file panel" },
          },
          {
            "n",
            "g<C-x>",
            function()
              require("diffview.actions").cycle_layout()
            end,
            { desc = "Cycle through available layouts." },
          },
          {
            "n",
            "[x",
            function()
              require("diffview.actions").prev_conflict()
            end,
            { desc = "In the merge_tool: jump to the previous conflict" },
          },
          {
            "n",
            "]x",
            function()
              require("diffview.actions").next_conflict()
            end,
            { desc = "In the merge_tool: jump to the next conflict" },
          },
          {
            "n",
            "g?",
            function()
              require("diffview.actions").help("file_panel")
            end,
            { desc = "Open the help panel" },
          },
        },
        file_history_panel = {
          {
            "n",
            "g!",
            function()
              require("diffview.actions").options()
            end,
            { desc = "Open the option panel" },
          },
          {
            "n",
            "<C-A-d>",
            function()
              require("diffview.actions").open_in_diffview()
            end,
            { desc = "Open the entry under the cursor in a diffview" },
          },
          {
            "n",
            "y",
            function()
              require("diffview.actions").copy_hash()
            end,
            { desc = "Copy the commit hash of the entry under the cursor" },
          },
          {
            "n",
            "L",
            function()
              require("diffview.actions").open_commit_log()
            end,
            { desc = "Show commit details" },
          },
          {
            "n",
            "zR",
            function()
              require("diffview.actions").open_all_folds()
            end,
            { desc = "Expand all folds" },
          },
          {
            "n",
            "zM",
            function()
              require("diffview.actions").close_all_folds()
            end,
            { desc = "Collapse all folds" },
          },
          {
            "n",
            "j",
            function()
              require("diffview.actions").next_entry()
            end,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "<down>",
            function()
              require("diffview.actions").next_entry()
            end,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "k",
            function()
              require("diffview.actions").prev_entry()
            end,
            { desc = "Bring the cursor to the previous file entry." },
          },
          {
            "n",
            "<up>",
            function()
              require("diffview.actions").prev_entry()
            end,
            { desc = "Bring the cursor to the previous file entry." },
          },
          {
            "n",
            "<cr>",
            function()
              require("diffview.actions").select_entry()
            end,
            { desc = "Open the diff for the selected entry." },
          },
          {
            "n",
            "o",
            function()
              require("diffview.actions").select_entry()
            end,
            { desc = "Open the diff for the selected entry." },
          },
          {
            "n",
            "<2-LeftMouse>",
            function()
              require("diffview.actions").select_entry()
            end,
            { desc = "Open the diff for the selected entry." },
          },
          {
            "n",
            "<c-b>",
            function()
              require("diffview.actions").scroll_view(-0.25)
            end,
            { desc = "Scroll the view up" },
          },
          {
            "n",
            "<c-f>",
            function()
              require("diffview.actions").scroll_view(0.25)
            end,
            { desc = "Scroll the view down" },
          },
          {
            "n",
            "<tab>",
            function()
              require("diffview.actions").select_next_entry()
            end,
            { desc = "Open the diff for the next file" },
          },
          {
            "n",
            "<s-tab>",
            function()
              require("diffview.actions").select_prev_entry()
            end,
            { desc = "Open the diff for the previous file" },
          },
          {
            "n",
            "gf",
            function()
              require("diffview.actions").goto_file()
            end,
            { desc = "Open the file in a new split in the previous tabpage" },
          },
          {
            "n",
            "<C-w><C-f>",
            function()
              require("diffview.actions").goto_file_split()
            end,
            { desc = "Open the file in a new split" },
          },
          {
            "n",
            "<C-w>gf",
            function()
              require("diffview.actions").goto_file_tab()
            end,
            { desc = "Open the file in a new tabpage" },
          },
          {
            "n",
            "<leader>e",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle the file panel" },
          },
          {
            "n",
            "<leader>b",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle the file panel" },
          },
          {
            "n",
            "g<C-x>",
            function()
              require("diffview.actions").cycle_layout()
            end,
            { desc = "Cycle through available layouts." },
          },
          {
            "n",
            "g?",
            function()
              require("diffview.actions").help("file_history_panel")
            end,
            { desc = "Open the help panel" },
          },
        },
        option_panel = {
          {
            "n",
            "<tab>",
            function()
              require("diffview.actions").select_entry()
            end,
            { desc = "Change the current option" },
          },
          {
            "n",
            "q",
            function()
              require("diffview.actions").close()
            end,
            { desc = "Close the diffview" },
          },
          {
            "n",
            "<esc>",
            function()
              require("diffview.actions").close()
            end,
            { desc = "Close the diffview" },
          },
          {
            "n",
            "g?",
            function()
              require("diffview.actions").help("option_panel")
            end,
            { desc = "Open the help panel" },
          },
        },
        help_panel = {
          {
            "n",
            "q",
            function()
              require("diffview.actions").close()
            end,
            { desc = "Close help menu" },
          },
          {
            "n",
            "<esc>",
            function()
              require("diffview.actions").close()
            end,
            { desc = "Close help menu" },
          },
        },
      },
    },
  },

  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })
    end,
  },
}