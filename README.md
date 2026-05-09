# 🚀 SuperVim - VSCode Alternative for Neovim

<div align="center">

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-brightgreen.svg)](https://neovim.io/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Stars](https://img.shields.io/github/stars/vtnguyen04/supervim?style=social)](https://github.com/vtnguyen04/supervim)

*A comprehensive, modern Neovim configuration that rivals VSCode functionality*

[📖 Documentation](#-features) • [⚡ Quick Start](#-quick-start) • [🎨 Screenshots](#-screenshots) • [🔧 Configuration](#-configuration) • [🤝 Contributing](#-contributing)

</div>

## 🌟 Why SuperVim?

SuperVim transforms Neovim into a powerful, VSCode-like IDE while maintaining the speed and efficiency that makes Neovim legendary. Built with modern Lua configuration and following SOLID principles.

### ✨ Key Advantages

- 🚀 **Blazing Fast**: <200MB RAM vs VSCode's 400-800MB
- 🎨 **Beautiful UI**: Modern themes, transparent backgrounds, smooth animations
- 🧠 **Smart Code Intelligence**: Full LSP support with autocompletion, diagnostics
- 🔧 **Zero Configuration**: Works out of the box with sensible defaults
- 🌍 **Multi-Language**: Python, JavaScript, TypeScript, Go, Rust, Lua and more
- 📦 **Modular Design**: Clean, organized codebase following SOLID principles
- 🎯 **VSCode-like Experience**: Familiar keybindings and workflows

## 📦 Features

<details>
<summary><b>🎨 Modern UI & Themes</b></summary>

- **Tokyo Night Theme** with transparency support
- **Lualine Statusline** with Git integration and LSP info
- **Bufferline** for tab management
- **Alpha Dashboard** with custom welcome screen
- **Indent Guides** for better code structure visualization
- **Icons Support** with Nerd Fonts integration

</details>

<details>
<summary><b>📁 File Management</b></summary>

- **Neo-tree** file explorer with Git status integration
- **Telescope** fuzzy finder for files, text, buffers
- **Recent files** and project-wide search
- **Quick navigation** with breadcrumbs and outline
- **Auto-save** and session management

</details>

<details>
<summary><b>🧠 Code Intelligence</b></summary>

- **Mason** for automatic LSP server installation
- **Full LSP Support** for 20+ programming languages
- **Autocompletion** with snippets and AI suggestions
- **Real-time diagnostics** with inline error messages
- **Code actions** and refactoring tools
- **Hover documentation** and signature help

</details>

<details>
<summary><b>🐛 Debugging & Testing</b></summary>

- **DAP (Debug Adapter Protocol)** integration
- **Visual debugging** with breakpoints and watches
- **Python testing** with pytest integration
- **Multi-language debugging** support
- **Terminal integration** with floating windows

</details>

<details>
<summary><b>📝 Git Integration</b></summary>

- **Gitsigns** for line-by-line Git status
- **LazyGit** integration for visual Git operations
- **Diffview** for comparing changes and conflicts
- **Git blame** and commit browsing
- **Merge conflict resolution**

</details>

<details>
<summary><b>🐍 Python Powerhouse</b></summary>

- **Virtual Environment** automatic detection and switching
- **Pytest Integration** with test discovery and running
- **Python Debugging** with DAP
- **Black & isort** formatting
- **Type checking** with mypy
- **Docstring generation** with Google/Numpy style

</details>

<details>
<summary><b>🎨 Enhanced Interface (NEW!)</b></summary>

- **Beautiful tab management** with slanted bufferline
- **Smooth animations** and visual effects
- **Professional layouts** with sidebars and floating windows
- **Zen mode** and focus tools for distraction-free coding
- **Visual window picker** and smart navigation
- **Minimap integration** with syntax highlighting
- **Enhanced notifications** with Tokyo Night styling
- **Advanced terminal management** with multiple layouts

</details>

## 📱 Screenshots

### 🏠 Dashboard
![Dashboard](assets/screenshots/dashboard.png)
*SuperVim welcome screen with Alpha dashboard and quick access menu*

### 💻 Coding Experience
![Coding](assets/screenshots/coding.png)
*Python development with LSP autocompletion, diagnostics, and syntax highlighting*

### 🔍 Fuzzy Finding
![Telescope](assets/screenshots/telescope.png)
*Telescope fuzzy finder for files, symbols, and live grep search*

### 🌳 File Explorer
![Neo-tree](assets/screenshots/neotree.png)
*Neo-tree file explorer with Git status integration and file icons*

---

## ⚡ Quick Start

### Prerequisites

- **Neovim 0.9+**
- **Git**
- **Node.js 16+** (for some LSP servers)
- **Python 3.8+**
- **A Nerd Font** (recommended: [JetBrainsMono Nerd Font](https://www.nerdfonts.com/))

### 🚀 One-Line Installation

```bash
bash -c \"$(curl -fsSL https://raw.githubusercontent.com/vtnguyen04/supervim/main/install.sh)\"
```

### 📋 Manual Installation

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone SuperVim**:
   ```bash
   git clone https://github.com/vtnguyen04/supervim.git ~/.config/nvim
   ```

3. **Install dependencies**:
   ```bash
   cd ~/.config/nvim
   chmod +x install.sh
   ./install.sh
   ```

4. **Launch Neovim**:
   ```bash
   nvim
   ```

5. **Wait for plugins to install** (first launch only)

## 📖 Documentation

### 🎯 Key Mappings

#### General Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `Space` | Leader Key | Main modifier key |
| `Ctrl+h/j/k/l` | Navigate Panes | Move between splits |
| `Shift+h/l` | Switch Buffers | Previous/Next buffer |
| `Ctrl+\\` | Toggle Terminal | Floating terminal |

#### File Operations
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | File Explorer | Toggle Neo-tree |
| `<leader>ff` | Find Files | Telescope file finder |
| `<leader>fg` | Find Text | Search in files |
| `<leader>fr` | Recent Files | Recently opened files |
| `<leader>fb` | Find Buffers | Open buffers |

#### Code Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to definition |
| `gr` | Find References | Show all references |
| `K` | Hover Docs | Show documentation |
| `<leader>ca` | Code Actions | Available code actions |
| `<leader>rn` | Rename | Rename symbol |

#### Git Operations
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gg` | LazyGit | Open Git interface |
| `<leader>gd` | Git Diff | View changes |
| `<leader>gb` | Git Blame | Toggle line blame |
| `]c` / `[c` | Git Hunks | Next/Previous change |

#### Python Specific
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>vs` | Select Venv | Choose Python environment |
| `<leader>tr` | Run Test | Run nearest test |
| `<leader>tf` | Test File | Run all tests in file |
| `<leader>td` | Debug Test | Debug nearest test |

### 🔧 LSP Servers

SuperVim automatically installs and configures LSP servers for:

- **Python**: pyright, black, isort, flake8
- **JavaScript/TypeScript**: tsserver, prettier, eslint
- **Lua**: lua-language-server, stylua
- **Go**: gopls, gofumpt
- **Rust**: rust-analyzer, rustfmt
- **HTML/CSS**: html-lsp, css-lsp
- **JSON**: json-lsp
- **And many more...**

### 🐍 Python Setup

1. **Virtual Environment Detection**:
   ```bash
   # SuperVim automatically detects:
   - .venv/, venv/, env/ in project root
   - Conda environments
   - Pyenv environments
   ```

2. **Testing with Pytest**:
   ```bash
   # Install pytest in your virtual environment
   pip install pytest pytest-cov
   ```

3. **Debugging Setup**:
   ```bash
   # Install debugpy for Python debugging
   pip install debugpy
   ```

## 🎨 Customization

### 🎭 Themes

SuperVim comes with Tokyo Night theme, but you can easily switch:

```lua
-- In lua/plugins/ui.lua
{
  \"folke/tokyonight.nvim\",
  opts = {
    style = \"storm\", -- storm, moon, night, day
    transparent = false, -- Disable transparency
  }
}
```

Popular alternatives:
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
- [OneDark](https://github.com/navarasu/onedark.nvim)

### ⌨️ Custom Keymaps

Add your keymaps in `lua/config/keymaps.lua`:

```lua
local keymap = vim.keymap.set

-- Custom keymap example
keymap(\"n\", \"<leader>w\", \":w<CR>\", { desc = \"Save file\" })
```

### 🔌 Adding Plugins

Create a new file in `lua/plugins/` or add to existing ones:

```lua
-- lua/plugins/my-plugins.lua
return {
  {
    \"your/plugin\",
    config = function()
      -- Plugin configuration
    end,
  }
}
```

### 📷 Contributing Screenshots

Want to contribute better screenshots? Use the automated script:

```bash
./scripts/generate_screenshots.sh
```

Or take manual screenshots and save to `assets/screenshots/` with proper names.

## 🏗️ Architecture

SuperVim follows SOLID principles with a modular structure:

```
~/.config/nvim/
├── init.lua                 -- Main entry point
├── lua/
│   ├── config/             -- Core configuration
│   │   ├── options.lua     -- Neovim options
│   │   ├── keymaps.lua     -- Key bindings
│   │   ├── autocmds.lua    -- Auto commands
│   │   └── lazy.lua        -- Plugin manager setup
│   └── plugins/            -- Plugin configurations
│       ├── ui.lua          -- UI and themes
│       ├── editor.lua      -- Editor enhancements
│       ├── lsp.lua         -- Language Server Protocol
│       ├── git.lua         -- Git integration
│       ├── treesitter.lua  -- Syntax highlighting
│       ├── python.lua      -- Python specific
│       └── debug.lua       -- Debugging tools
├── install.sh              -- Installation script
└── README.md              -- This file
```

## 🚨 Troubleshooting

### Common Issues

<details>
<summary><b>LSP Server not working</b></summary>

1. Check if the server is installed:
   ```vim
   :Mason
   ```

2. Restart LSP:
   ```vim
   :LspRestart
   ```

3. Check logs:
   ```vim
   :LspInfo
   ```
</details>

<details>
<summary><b>Icons not showing</b></summary>

Install a Nerd Font and set it in your terminal:
- Download: [Nerd Fonts](https://www.nerdfonts.com/)
- Popular choice: JetBrainsMono Nerd Font
</details>

<details>
<summary><b>Python virtual environment not detected</b></summary>

1. Make sure your venv is in a standard location:
   - `.venv/`, `venv/`, `env/` in project root
   - Or use `<leader>vs` to manually select

2. Check venv-selector settings in `lua/plugins/python.lua`
</details>

<details>
<summary><b>Slow startup</b></summary>

1. Check startup time:
   ```vim
   :StartupTime
   ```

2. Disable unused plugins in `lua/plugins/`
</details>

## 🎯 Performance

SuperVim is optimized for performance:

- **Lazy Loading**: Plugins load only when needed
- **Optimized RTP**: Disabled unnecessary runtime plugins
- **Fast Startup**: <100ms startup time
- **Memory Efficient**: <200MB RAM usage
- **Treesitter**: Incremental parsing for large files

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes** following our code style
4. **Test thoroughly** with different file types
5. **Submit a pull request**

### 📋 Development Guidelines

- Follow Lua best practices
- Keep plugins modular and organized
- Add documentation for new features
- Test with multiple languages
- Maintain SOLID principles

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

SuperVim is built on the shoulders of giants:

- [Neovim](https://neovim.io/) - The hyperextensible Vim-based text editor
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - Package manager for LSP servers
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- All the amazing plugin authors in the Neovim ecosystem


## 🌊 Hyprland Integration

SuperVim now comes with a **beautiful Hyprland configuration** that perfectly matches the Tokyo Night theme!

### ✨ What's Included:
- 🎨 **Matching Tokyo Night theme** across all components
- ⌨️ **Vim-style keybindings** for window management
- 📊 **Custom Waybar** with SuperVim integration
- 🚀 **Rofi launcher** with Tokyo Night styling
- 🐱 **Kitty terminal** perfectly configured
- 🔔 **Dunst notifications** themed to match

### 🚀 Install Hyprland Setup:
```bash
# After installing SuperVim, add Hyprland configuration:
bash <(curl -fsSL https://raw.githubusercontent.com/vtnguyen04/SuperVim/main/install-hyprland.sh)
```

**Key Features:**
- `Super + N` → Open Neovim instantly
- `Super + H/J/K/L` → Vim-style window navigation
- Beautiful blur effects and animations
- Full Tokyo Night theme integration

[📖 Full Hyprland Documentation](hyprland-config/README.md)

## 🗺️ Roadmap

- [x] **AI Integration**: GitHub Copilot support ✅
- [x] **LSP Support**: Multi-language intelligence ✅
- [x] **Git Integration**: Full workflow support ✅
- [x] **Hyprland Integration**: Complete desktop environment ✅
- [ ] **More Languages**: Java, C++, C# support
- [ ] **Better Testing**: Integration with more test frameworks
- [ ] **Snippets**: Custom snippet collection
- [ ] **Documentation**: Video tutorials
- [ ] **Mobile**: Termux support for Android
- [ ] **Cloud Sync**: Configuration synchronization
- [ ] **Themes**: More colorscheme options

## 💬 Community

- **GitHub Discussions**: [Ask questions and share tips](https://github.com/vtnguyen04/supervim/discussions)
- **Reddit**: [r/neovim](https://reddit.com/r/neovim)

## 📊 Stats

- **Languages Supported**: 20+
- **Plugins Included**: 50+
- **Lines of Config**: 2000+
- **Installation Time**: <5 minutes
- **Startup Time**: <100ms

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=vtnguyen04/supervim&type=Date)](https://star-history.com/#vtnguyen04/supervim&Date)

---

<div align="center">

**Made with ❤️ for the Vim community**

[⬆️ Back to Top](#-supervim---vscode-alternative-for-neovim)

</div>