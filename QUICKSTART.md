# 🚀 SuperVim Quick Start Guide

## ✅ Cài Đặt Hoàn Tất!

SuperVim đã được cài đặt thành công tại `~/.config/nvim/`. Config cũ của bạn đã được backup an toàn.

## 🎯 Bắt Đầu Ngay

### 1. Khởi động Neovim
```bash
nvim
```

**Lưu ý**: Lần đầu khởi động sẽ mất 1-2 phút để tải plugins. Hãy kiên nhẫn!

### 2. Test với file demo
```bash
nvim ~/Documents/SuperVim/demo.py
```

## ⌨️  Phím Tắt Cơ Bản

### File Operations
| Phím | Chức năng |
|------|----------|
| `<Space>e` | Mở/đóng file explorer |
| `<Space>ff` | Tìm file |
| `<Space>fg` | Tìm text trong project |
| `<Space>fr` | File gần đây |
| `<Space>fb` | Buffer đang mở |

### Code Navigation
| Phím | Chức năng |
|------|----------|
| `gd` | Đi đến định nghĩa |
| `gr` | Tìm tham chiếu |
| `K` | Xem documentation |
| `<Space>ca` | Code actions |
| `<Space>rn` | Rename symbol |

### Python Specific
| Phím | Chức năng |
|------|----------|
| `<Space>vs` | Chọn Python venv |
| `<Space>tr` | Chạy test gần cursor |
| `<Space>tf` | Chạy test file |
| `<Space>db` | Toggle breakpoint |

### Git Operations
| Phím | Chức năng |
|------|----------|
| `<Space>gg` | Mở LazyGit |
| `<Space>gd` | Git diff |
| `<Space>gb` | Git blame |

### Terminal
| Phím | Chức năng |
|------|----------|
| `<Ctrl>\` | Toggle terminal |
| `<Space>tf` | Float terminal |

## 🐍 Setup Python Development

1. **Tạo virtual environment**:
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # Linux/Mac
   # hoặc .venv\Scripts\activate  # Windows
   ```

2. **Install Python packages**:
   ```bash
   pip install black isort flake8 mypy pytest debugpy
   ```

3. **Trong Neovim, chọn venv**:
   ```
   <Space>vs  # Chọn virtual environment
   ```

## 🔧 Troubleshooting

### Lần đầu chậm?
- ✅ Bình thường! Plugins đang tải lần đầu
- ⏳ Đợi cho đến khi thấy "Lazy" ở bottom status

### LSP không hoạt động?
```vim
:Mason          " Mở Mason để cài LSP servers
:LspInfo        " Kiểm tra LSP status
:Lazy           " Kiểm tra plugins
```

### Icons không hiện?
- Cài Nerd Font: [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)
- Set terminal font thành "JetBrainsMono Nerd Font"

### Python venv không detect?
- Đảm bảo venv ở `.venv/`, `venv/`, `env/`
- Hoặc dùng `<Space>vs` để chọn thủ công

## 🔄 Khôi Phục Config Cũ

Nếu muốn quay lại config cũ:
```bash
# Tìm file backup
ls ~/.config/nvim.backup.*

# Xóa SuperVim và restore
rm -rf ~/.config/nvim
mv ~/.config/nvim.backup.YYYYMMDD_HHMMSS ~/.config/nvim
```

## 📚 Học Thêm

- **README.md**: Hướng dẫn đầy đủ
- **SHOWCASE.md**: Ví dụ thực tế
- **demo.py**: File test tính năng
- `:help` trong Neovim

## 🎉 Chúc Mừng!

Bạn đã sẵn sàng coding với SuperVim! Hãy thử:

1. Mở project Python: `nvim your_project/`
2. Dùng `<Space>ff` để tìm file
3. Code với LSP intelligence
4. Debug với `<Space>db` và `<Space>dc`
5. Commit với `<Space>gg`

**Happy coding! 🚀**