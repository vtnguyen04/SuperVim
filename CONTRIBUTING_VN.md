# 🤝 Hướng dẫn Đóng góp cho SuperVim

Cảm ơn bạn quan tâm đến việc đóng góp cho SuperVim! Hướng dẫn này sẽ giúp bạn bắt đầu.

## 🚀 Cách thức đóng góp

### 1. Báo cáo lỗi (Bug Reports)
- Sử dụng [GitHub Issues](https://github.com/yourusername/supervim/issues)
- Mô tả chi tiết vấn đề, bước tái tạo
- Kèm theo phiên bản Neovim và hệ điều hành
- Nếu có thể, cung cấp minimal config để tái tạo lỗi

### 2. Đề xuất tính năng (Feature Requests)
- Mở issue với label `enhancement`
- Giải thích rõ ràng tính năng mong muốn
- Mô tả use case và lý do cần thiết
- Thảo luận với cộng đồng trước khi implement

### 3. Đóng góp code

#### Quy trình cơ bản:
1. **Fork repository**
2. **Clone fork về máy local**
   ```bash
   git clone https://github.com/yourusername/supervim.git
   cd supervim
   ```

3. **Tạo branch cho feature/fix**
   ```bash
   git checkout -b feature/ten-tinh-nang
   # hoặc
   git checkout -b fix/ten-loi-can-sua
   ```

4. **Develop và test**
   - Thực hiện thay đổi
   - Test kỹ với nhiều file types khác nhau
   - Chạy health check: `:checkhealth supervim`

5. **Commit và push**
   ```bash
   git add .
   git commit -m "feat: thêm tính năng XYZ"
   git push origin feature/ten-tinh-nang
   ```

6. **Tạo Pull Request**
   - Mô tả chi tiết thay đổi
   - Link đến issue liên quan (nếu có)
   - Thêm screenshots nếu có UI changes

## 📋 Coding Standards

### Lua Code Style
```lua
-- Tốt ✅
local M = {}

function M.setup_feature()
  local opts = {
    enable = true,
    timeout = 1000,
  }

  if opts.enable then
    print("Feature enabled")
  end
end

return M
```

### Plugin Configuration
```lua
-- Structure cho plugin configs
return {
  {
    "author/plugin-name",
    dependencies = { "required/plugin" },
    event = "BufReadPost",
    opts = {
      -- configuration options
    },
    config = function(_, opts)
      require("plugin-name").setup(opts)
    end,
    keys = {
      { "<leader>key", "<cmd>Command<cr>", desc = "Description" },
    },
  },
}
```

### Keymaps Convention
- `<leader>` = Space
- `<leader>f` = Find/Search operations
- `<leader>g` = Git operations
- `<leader>c` = Code operations
- `<leader>t` = Terminal/Testing
- `<leader>d` = Debug operations

### File Organization
```
lua/
├── config/          # Core configuration
│   ├── options.lua  # Neovim options
│   ├── keymaps.lua  # Key mappings
│   ├── autocmds.lua # Auto commands
│   └── lazy.lua     # Plugin manager setup
├── plugins/         # Plugin configurations
│   ├── ui.lua       # UI and themes
│   ├── editor.lua   # Editor enhancements
│   ├── lsp.lua      # Language Server Protocol
│   ├── git.lua      # Git integration
│   └── ...
└── utils/          # Utility functions
    └── init.lua    # Helper functions
```

## 🧪 Testing Guidelines

### Trước khi submit PR:
1. **Test với multiple file types:**
   ```bash
   nvim test.py    # Python
   nvim test.js    # JavaScript
   nvim test.lua   # Lua
   nvim test.go    # Go
   nvim test.rs    # Rust
   ```

2. **Chạy health check:**
   ```vim
   :checkhealth supervim
   ```

3. **Test LSP functionality:**
   ```vim
   :LspInfo
   :Mason
   ```

4. **Test key mappings:**
   - `<leader>ff` - Find files
   - `<leader>e` - File explorer
   - `<leader>gg` - Git interface
   - `gd` - Go to definition

### Test Cases cần cover:
- Fresh install (no existing config)
- Upgrade from older version
- Different operating systems (Linux, macOS, Windows)
- Various terminal emulators
- Different Neovim versions (0.9+)

## 📦 Plugin Integration

### Khi thêm plugin mới:
1. **Đảm bảo plugin stable và được maintain**
2. **Không conflict với existing plugins**
3. **Có lazy loading để tối ưu performance**
4. **Thêm appropriate keymaps**
5. **Update documentation**

### Plugin categories:
- `ui.lua` - Themes, statusline, bufferline
- `editor.lua` - File navigation, search, terminal
- `lsp.lua` - Language servers, completion
- `git.lua` - Git integration
- `python.lua` - Python-specific features
- `debug.lua` - Debugging tools
- `treesitter.lua` - Syntax highlighting

## 🐛 Debugging

### Common issues và solutions:

1. **Plugin không load:**
   ```vim
   :Lazy reload plugin-name
   ```

2. **LSP không hoạt động:**
   ```vim
   :LspRestart
   :Mason
   ```

3. **Keymaps không work:**
   ```vim
   :verbose map <leader>key
   ```

4. **Performance issues:**
   ```vim
   :startuptime
   ```

## 📚 Documentation

### Khi thay đổi config:
- Update README.md nếu cần
- Update keymaps table
- Thêm comments rõ ràng trong code
- Update CHANGELOG.md

### Format cho commit messages:
```
type(scope): description

feat(lsp): add support for new language server
fix(ui): resolve theme transparency issue
docs(readme): update installation instructions
refactor(config): reorganize plugin structure
```

## 🌟 Recognition

Contributors sẽ được ghi nhận trong:
- README.md Contributors section
- Release notes
- Special thanks trong documentation

## 💡 Tips for Contributors

1. **Start small** - Fix documentation, small bugs trước
2. **Communicate** - Discuss trong issues trước khi code
3. **Be patient** - Review process có thể mất thời gian
4. **Learn from feedback** - Comments trong PR là để improve
5. **Stay updated** - Follow project để biết latest changes

## 🆘 Cần hỗ trợ?

- 📧 Email: [maintainer-email]
- 💬 GitHub Discussions
- 🐛 GitHub Issues cho bugs
- 📝 Wiki cho documentation

---

**Cảm ơn bạn đã đóng góp cho SuperVim! 🎉**

Mọi đóng góp, dù nhỏ hay lớn, đều được đánh giá cao và giúp cộng đồng Neovim phát triển mạnh hơn.

---
*SuperVim được xây dựng với ❤️ cho cộng đồng Vim/Neovim*