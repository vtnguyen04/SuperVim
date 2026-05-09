# 🎬 SuperVim Showcase

Các ví dụ thực tế về cách sử dụng SuperVim trong development hàng ngày.

## 🐍 Python Development

### Virtual Environment Management
```bash
# SuperVim tự động detect và switch venv
<Space>vs  # Chọn Python environment
```

### Code Intelligence
```python
# Hover documentation với K
def fibonacci(n: int) -> int:
    """Calculate fibonacci number."""
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

# Go to definition với gd
from math import sqrt  # Ctrl+click hoặc gd để jump

# Find references với gr
result = fibonacci(10)  # gr để tìm tất cả usage
```

### Testing & Debugging
```python
# pytest integration
<Space>tr  # Run test gần cursor
<Space>tf  # Run tất cả tests trong file
<Space>td  # Debug test

# Breakpoint debugging
<Space>db  # Toggle breakpoint
<Space>dc  # Start debugging
```

## 🌐 Web Development

### JavaScript/TypeScript
```javascript
// Auto-completion và error detection
interface User {
    id: number;
    name: string;
    email?: string;  // Optional property
}

const user: User = {
    id: 1,
    name: "John"  // TypeScript sẽ check types
};

// Refactoring
function getUserName(user) {  // <Space>rn để rename
    return user.name;
}
```

### HTML/CSS
```html
<!-- Emmet support và auto-complete -->
<div class="container">
    <h1>Welcome</h1>
    <p>Auto-closing tags và indentation</p>
</div>
```

## 🔧 Git Workflow

### Visual Git Operations
```bash
<Space>gg    # LazyGit interface
<Space>gd    # Git diff viewer
<Space>gb    # Git blame
]c / [c      # Navigate git hunks
<Space>hs    # Stage hunk
<Space>hr    # Reset hunk
```

### Merge Conflicts
```
<<<<<<< HEAD
const version = "1.0.0";
=======
const version = "2.0.0";
>>>>>>> feature/update

# SuperVim highlight conflicts và provide tools để resolve
```

## 🔍 Advanced Search & Navigation

### Telescope Features
```bash
<Space>ff    # Tìm files (support gitignore)
<Space>fg    # Live grep với preview
<Space>fr    # Recent files
<Space>fb    # Open buffers
<Space>fh    # Help tags
<Space>fs    # Symbols in document
```

### File Explorer
```bash
<Space>e     # Toggle Neo-tree
<Space>o     # Focus file explorer

# Trong Neo-tree:
a            # Add file/folder
d            # Delete
r            # Rename
c            # Copy
x            # Cut
```

## 🚀 Performance Features

### Lazy Loading
```lua
-- Plugins chỉ load khi cần
-- Startup time < 100ms
-- Memory usage < 200MB
```

### LSP Performance
```bash
:LspInfo     # Check LSP status
:Mason       # Manage language servers
:Lazy        # Plugin manager UI
```

## 🎨 Customization Examples

### Theme Switching
```lua
-- lua/plugins/ui.lua
{
  "folke/tokyonight.nvim",
  opts = {
    style = "storm",        -- storm, moon, night, day
    transparent = true,     -- Trong suốt
    terminal_colors = true,
  }
}
```

### Custom Keybindings
```lua
-- lua/config/keymaps.lua
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })
```

### New Language Support
```lua
-- lua/plugins/lsp.lua
servers = {
  -- Thêm language server mới
  rust_analyzer = {},
  gopls = {},
  clangd = {},
}
```

## 📊 Productivity Metrics

### Before SuperVim
- ⏱️ Setup time: 2-3 giờ
- 💾 RAM usage: 400-800MB (VSCode)
- 🐌 Startup: 3-5 giây
- 🔧 Configuration: Phức tạp, GUI

### After SuperVim
- ⏱️ Setup time: 5 phút
- 💾 RAM usage: <200MB
- 🚀 Startup: <100ms
- 🔧 Configuration: Code-based, version controlled

## 🏆 Real-world Workflows

### Full-stack Development
```bash
# 1. Open project
nvim .

# 2. Find và edit files
<Space>ff

# 3. Run tests
<Space>tr

# 4. Git operations
<Space>gg

# 5. Debug issues
<Space>db
<Space>dc

# 6. Deploy
<Space>tf (terminal float)
```

### Data Science (Python)
```python
# 1. Jupyter-like experience
# 2. Virtual env management
# 3. Pandas/NumPy intelligence
# 4. Plotting integration
# 5. Git versioning for notebooks
```

## 🎯 Pro Tips

### Speed Hacks
- `<Space>` Leader key cho mọi thao tác
- `jj` để escape (nếu muốn config)
- `<C-h/j/k/l>` để navigate splits
- `<S-h/l>` để switch buffers

### Code Navigation
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<C-o>/<C-i>` - Jump back/forward

### Terminal Integration
- `<C-\>` - Toggle terminal
- `<Space>tf` - Float terminal
- `<Space>th` - Horizontal split
- `<Space>tv` - Vertical split

## 🔮 Advanced Features

### AI Integration (Coming Soon)
```bash
# GitHub Copilot support
# ChatGPT integration
# Code generation
```

### Multi-language Projects
```
project/
├── frontend/ (TypeScript)
├── backend/ (Python)
├── mobile/ (Dart/Flutter)
└── docs/ (Markdown)

# SuperVim handles all trong 1 session
```

---

*Showcase này update liên tục với features mới và use cases thực tế từ community.*