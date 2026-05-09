# 🌊 SuperVim + Hyprland Configuration

<div align="center">

![Tokyo Night Theme](https://img.shields.io/badge/Theme-Tokyo%20Night-7aa2f7?style=for-the-badge)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-00d9ff?style=for-the-badge)
![Wayland](https://img.shields.io/badge/Protocol-Wayland-ffc107?style=for-the-badge)

*Beautiful Hyprland configuration matching SuperVim's Tokyo Night theme*

</div>

## ✨ Features

- 🎨 **Tokyo Night theme** matching SuperVim perfectly
- 🚀 **Vim-style keybindings** for window management
- 💎 **Beautiful animations** and blur effects
- 📊 **Custom Waybar** with SuperVim integration
- 🚀 **Rofi launcher** with Tokyo Night styling
- 🔔 **Dunst notifications** themed to match
- 🐱 **Kitty terminal** with full Tokyo Night colors
- ⚡ **SuperVim shortcuts** built into Hyprland

## 🚀 Quick Install

```bash
# Make sure SuperVim is installed first
bash <(curl -fsSL https://raw.githubusercontent.com/vtnguyen04/SuperVim/main/install.sh)

# Then install Hyprland configuration
bash <(curl -fsSL https://raw.githubusercontent.com/vtnguyen04/SuperVim/main/install-hyprland.sh)
```

## ⌨️ Key Bindings

### Window Management (Vim-style)
| Key | Action |
|-----|--------|
| `Super + H/J/K/L` | Move focus (Vim directions) |
| `Super + Shift + H/J/K/L` | Move windows |
| `Super + Ctrl + H/J/K/L` | Resize windows |

### Applications
| Key | Action |
|-----|--------|
| `Super + Return` | Terminal (Kitty) |
| `Super + N` | Neovim |
| `Super + Shift + N` | Neovim in current directory |
| `Super + D` | App launcher (Rofi) |
| `Super + E` | File manager |

### System
| Key | Action |
|-----|--------|
| `Super + Q` | Close window |
| `Super + M` | Exit Hyprland |
| `Super + V` | Toggle floating |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move to workspace |

## 🎨 Components

### 🖥️ **Hyprland**
- Tokyo Night color scheme
- Smooth animations with bezier curves
- Blur effects and transparency
- Vim-style navigation
- Smart window rules

### 📊 **Waybar**
- Custom Tokyo Night styling
- SuperVim integration (shows nvim in title)
- System monitoring widgets
- Beautiful icons and animations

### 🚀 **Rofi**
- Tokyo Night theme
- App launcher with icons
- Window switcher mode
- Custom styling to match theme

### 🐱 **Kitty Terminal**
- Full Tokyo Night color palette
- Optimized for SuperVim
- Custom key bindings
- Perfect font rendering

### 🔔 **Dunst**
- Tokyo Night notification theme
- SuperVim-specific notification rules
- Beautiful rounded corners
- Smart positioning

## 📁 File Structure

```
~/.config/
├── hypr/
│   ├── hyprland.conf      # Main Hyprland config
│   ├── hyprpaper.conf     # Wallpaper config
│   └── wallpapers/        # Theme wallpapers
├── waybar/
│   ├── config.json        # Waybar configuration
│   └── style.css          # Tokyo Night styling
├── rofi/
│   ├── config.rasi        # Rofi configuration
│   └── tokyo-night.rasi   # Tokyo Night theme
├── kitty/
│   └── kitty.conf         # Terminal configuration
└── dunst/
    └── dunstrc            # Notification config
```

## 🛠️ Manual Installation

If you prefer to install manually:

```bash
# 1. Install required packages (Arch Linux example)
sudo pacman -S hyprland waybar rofi dunst kitty grim slurp wl-clipboard

# 2. Clone SuperVim
git clone https://github.com/vtnguyen04/SuperVim.git
cd SuperVim

# 3. Copy configurations
cp -r hyprland-config/* ~/.config/

# 4. Install fonts
# Download JetBrainsMono Nerd Font from nerdfonts.com

# 5. Start Hyprland
Hyprland
```

## 🎯 Customization

### Colors
All colors are defined in the Tokyo Night palette:
- `#1a1b26` - Background
- `#7aa2f7` - Primary blue
- `#9ece6a` - Green
- `#f7768e` - Red
- `#bb9af7` - Purple
- `#e0af68` - Yellow

### Keybindings
Edit `~/.config/hypr/hyprland.conf` to customize keybindings.

### Waybar
Modify `~/.config/waybar/config.json` and `style.css` to customize the bar.

## 🐛 Troubleshooting

**Hyprland won't start:**
- Check if you have a compatible GPU driver
- Ensure you're not running X11 session

**Missing icons in Waybar:**
- Install a Nerd Font (JetBrainsMono recommended)
- Install an icon theme like Papirus

**SuperVim not opening correctly:**
- Make sure SuperVim is properly installed
- Check terminal emulator is set to kitty

## 🤝 Contributing

Feel free to:
- Submit issues for bugs or improvements
- Create pull requests with enhancements
- Share your customizations
- Suggest new features

## 📄 License

This configuration is part of SuperVim project and follows the same MIT license.

---

<div align="center">

**Part of the SuperVim ecosystem** ✨

[SuperVim Repository](https://github.com/vtnguyen04/SuperVim) | [Documentation](https://github.com/vtnguyen04/SuperVim/blob/main/README.md)

</div>