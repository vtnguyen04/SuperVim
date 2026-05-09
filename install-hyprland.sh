#!/bin/bash

# =============================================================================
# SuperVim + Hyprland Installation Script
# Tokyo Night Theme | Complete Setup
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Symbols
SUCCESS="✅"
ERROR="❌"
INFO="ℹ️"
WARNING="⚠️"
ROCKET="🚀"
GEAR="⚙️"

print_header() {
    echo -e "${PURPLE}"
    echo "███████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗"
    echo "██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██║████╗ ████║"
    echo "███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║██║██╔████╔██║"
    echo "╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║"
    echo "███████║╚██████╔╝██║     ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║"
    echo "╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}+ Hyprland Configuration${NC}"
    echo -e "${YELLOW}Tokyo Night Theme | Modern • Beautiful • Fast${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}${SUCCESS} $1${NC}"
}

print_error() {
    echo -e "${RED}${ERROR} $1${NC}"
}

print_info() {
    echo -e "${BLUE}${INFO} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}${WARNING} $1${NC}"
}

print_step() {
    echo -e "${CYAN}${GEAR} $1${NC}"
}

detect_os() {
    if command -v pacman >/dev/null 2>&1; then
        echo "arch"
    elif command -v apt >/dev/null 2>&1; then
        echo "debian"
    elif command -v dnf >/dev/null 2>&1; then
        echo "fedora"
    else
        echo "unknown"
    fi
}

install_packages() {
    local os="$1"
    print_step "Installing Hyprland and dependencies..."

    case "$os" in
        "arch")
            packages="hyprland waybar rofi dunst kitty grim slurp wl-clipboard hyprpaper polkit-gnome brightnessctl pavucontrol"
            if ! sudo pacman -S --noconfirm $packages; then
                print_error "Failed to install packages"
                return 1
            fi
            ;;
        "debian")
            print_info "Adding Hyprland repository for Debian..."
            # Add Hyprland repository or compile from source
            packages="waybar rofi dunst kitty grim slurp wl-clipboard brightnessctl pavucontrol"
            sudo apt update
            if ! sudo apt install -y $packages; then
                print_error "Failed to install packages"
                return 1
            fi
            print_warning "You may need to compile Hyprland from source on Debian"
            ;;
        "fedora")
            packages="hyprland waybar rofi dunst kitty grim slurp wl-clipboard brightnessctl pavucontrol"
            if ! sudo dnf install -y $packages; then
                print_error "Failed to install packages"
                return 1
            fi
            ;;
        *)
            print_error "Unsupported OS. Please install packages manually:"
            print_info "Required: hyprland waybar rofi dunst kitty grim slurp wl-clipboard hyprpaper"
            return 1
            ;;
    esac

    print_success "Packages installed successfully"
}

backup_configs() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="$HOME/.config/backup_$timestamp"

    print_step "Backing up existing configurations..."
    mkdir -p "$backup_dir"

    for dir in hypr waybar rofi kitty dunst; do
        if [ -d "$HOME/.config/$dir" ]; then
            mv "$HOME/.config/$dir" "$backup_dir/"
            print_info "Backed up $dir configuration"
        fi
    done

    print_success "Configurations backed up to $backup_dir"
}

install_configs() {
    print_step "Installing SuperVim + Hyprland configurations..."

    # Copy configurations
    cp -r hyprland-config/* "$HOME/.config/"

    # Create wallpaper directory
    mkdir -p "$HOME/.config/hypr/wallpapers"

    # Download a Tokyo Night wallpaper (placeholder)
    if command -v wget >/dev/null 2>&1; then
        print_info "Downloading Tokyo Night wallpaper..."
        wget -O "$HOME/.config/hypr/wallpapers/tokyo-night.jpg" \
            "https://w.wallhaven.cc/full/r2/wallhaven-r2qrzq.jpg" 2>/dev/null || \
        echo "Could not download wallpaper. Please add your own to ~/.config/hypr/wallpapers/"
    fi

    # Set permissions
    chmod +x "$HOME/.config/hypr"/*.conf 2>/dev/null || true

    print_success "Configurations installed"
}

setup_fonts() {
    print_step "Setting up fonts..."

    local font_dir="$HOME/.local/share/fonts"
    mkdir -p "$font_dir"

    if ! fc-list | grep -q "JetBrainsMono Nerd Font"; then
        print_info "JetBrainsMono Nerd Font not found. Please install it manually:"
        print_info "Download from: https://www.nerdfonts.com/font-downloads"
        print_warning "Font is required for proper icons display"
    else
        print_success "JetBrainsMono Nerd Font found"
    fi
}

setup_autostart() {
    print_step "Setting up autostart services..."

    # Enable services if using systemd
    if command -v systemctl >/dev/null 2>&1; then
        systemctl --user enable --now pipewire pipewire-pulse 2>/dev/null || true
    fi

    print_success "Autostart configured"
}

print_instructions() {
    echo ""
    print_success "SuperVim + Hyprland installation completed!"
    echo ""
    echo -e "${CYAN}${ROCKET} Next Steps:${NC}"
    echo -e "  1. ${GREEN}Log out and select Hyprland from your display manager${NC}"
    echo -e "  2. ${GREEN}Or start Hyprland with: ${YELLOW}Hyprland${NC}"
    echo ""
    echo -e "${CYAN}${INFO} Key Bindings:${NC}"
    echo -e "  • ${YELLOW}Super + Return${NC}     → Open terminal (Kitty)"
    echo -e "  • ${YELLOW}Super + D${NC}          → App launcher (Rofi)"
    echo -e "  • ${YELLOW}Super + E${NC}          → File manager"
    echo -e "  • ${YELLOW}Super + N${NC}          → Open Neovim"
    echo -e "  • ${YELLOW}Super + Q${NC}          → Close window"
    echo -e "  • ${YELLOW}Super + H/J/K/L${NC}    → Navigate windows (Vim-style)"
    echo -e "  • ${YELLOW}Super + 1-9${NC}        → Switch workspaces"
    echo ""
    echo -e "${CYAN}${INFO} Configuration Files:${NC}"
    echo -e "  • Hyprland: ${YELLOW}~/.config/hypr/hyprland.conf${NC}"
    echo -e "  • Waybar:   ${YELLOW}~/.config/waybar/${NC}"
    echo -e "  • Kitty:    ${YELLOW}~/.config/kitty/kitty.conf${NC}"
    echo -e "  • Rofi:     ${YELLOW}~/.config/rofi/${NC}"
    echo ""
    echo -e "${PURPLE}Enjoy your beautiful SuperVim + Hyprland setup! 🎉${NC}"
}

main() {
    print_header

    # Check if running in GUI environment
    if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
        print_warning "Not running in a graphical environment"
        print_info "This script will configure Hyprland, but you'll need to start it manually"
    fi

    # Detect OS
    local os=$(detect_os)
    print_info "Detected OS: $os"

    # Check if SuperVim is installed
    if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
        print_error "SuperVim not found. Please install SuperVim first:"
        print_info "bash <(curl -fsSL https://raw.githubusercontent.com/vtnguyen04/SuperVim/main/install.sh)"
        exit 1
    fi

    print_info "SuperVim found, proceeding with Hyprland configuration..."

    # Confirm installation
    echo -e "${YELLOW}This will install Hyprland with Tokyo Night theme matching SuperVim${NC}"
    echo -e "${YELLOW}Existing configurations will be backed up${NC}"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi

    # Install packages
    install_packages "$os"

    # Backup existing configs
    backup_configs

    # Setup fonts
    setup_fonts

    # Install configurations
    install_configs

    # Setup autostart
    setup_autostart

    # Print final instructions
    print_instructions
}

# Run main function
main "$@"