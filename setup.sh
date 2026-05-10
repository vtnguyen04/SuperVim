#!/bin/bash

# =============================================================================
# SuperVim Setup Script - Backup và Install
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
    echo "██████╗ ██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗"
    echo "██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██║████╗ ████║"
    echo "███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║██║██╔████╔██║"
    echo "╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║"
    echo "███████║╚██████╔╝██║     ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║"
    echo "╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}SuperVim Setup - Backup Current Config & Install${NC}"
    echo ""
}

print_info() {
    echo -e "${BLUE}${INFO} $1${NC}"
}

print_success() {
    echo -e "${GREEN}${SUCCESS} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}${WARNING} $1${NC}"
}

print_error() {
    echo -e "${RED}${ERROR} $1${NC}"
}

print_step() {
    echo -e "${PURPLE}${GEAR} $1${NC}"
}

main() {
    clear
    print_header

    # Check if we're in SuperVim directory
    if [ ! -f "init.lua" ] || [ ! -d "lua" ]; then
        print_error "Please run this script from SuperVim directory"
        exit 1
    fi

    print_info "Current Neovim config will be backed up safely"
    print_info "SuperVim will be installed as new config"
    echo ""

    read -p "Continue? (y/N): " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Setup cancelled"
        exit 0
    fi

    echo ""

    # 1. Backup existing config
    BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    if [ -d "$HOME/.config/nvim" ]; then
        print_step "Backing up current Neovim config..."
        mv "$HOME/.config/nvim" "$BACKUP_DIR"
        print_success "Backup created at $BACKUP_DIR"

        # Also backup data directory
        DATA_DIR="$HOME/.local/share/nvim"
        if [ -d "$DATA_DIR" ]; then
            DATA_BACKUP="${DATA_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$DATA_DIR" "$DATA_BACKUP"
            print_info "Neovim data backed up to $DATA_BACKUP"
        fi
    fi

    # 2. Install SuperVim
    print_step "Installing SuperVim configuration..."
    mkdir -p "$HOME/.config"
    
    # Use symlink for better development experience
    if [ -d "$HOME/.config/nvim" ]; then
        rm -rf "$HOME/.config/nvim"
    fi
    ln -s "$(pwd)" "$HOME/.config/nvim"
    print_success "SuperVim linked to ~/.config/nvim (Symlink Mode)"

    # 3. Create restore script
    print_step "Creating restore script..."
    cat > "$HOME/.config/restore_original_nvim.sh" << EOF
#!/bin/bash
# Script to restore original Neovim config

echo "Restoring original Neovim configuration..."

if [ -d "$HOME/.config/nvim" ]; then
    rm -rf "$HOME/.config/nvim"
fi

if [ -d "$BACKUP_DIR" ]; then
    mv "$BACKUP_DIR" "$HOME/.config/nvim"
    echo "✅ Original config restored"
else
    echo "❌ Backup not found at $BACKUP_DIR"
fi

# Restore data if exists
if [ -d "$DATA_BACKUP" ]; then
    rm -rf "$HOME/.local/share/nvim"
    mv "$DATA_BACKUP" "$HOME/.local/share/nvim"
    echo "✅ Neovim data restored"
fi

echo "🔄 Run 'nvim' to use original configuration"
EOF

    chmod +x "$HOME/.config/restore_original_nvim.sh"
    print_success "Restore script created at ~/.config/restore_original_nvim.sh"

    # 4. Success message
    echo ""
    echo -e "${GREEN}${ROCKET} SuperVim setup completed!${NC}"
    echo ""
    echo -e "${CYAN}Next Steps:${NC}"
    echo -e "${YELLOW}1.${NC} Launch Neovim: ${BLUE}nvim${NC}"
    echo -e "${YELLOW}2.${NC} Wait for plugins to install (first launch)"
    echo -e "${YELLOW}3.${NC} Try demo file: ${BLUE}nvim ~/Documents/SuperVim/demo.py${NC}"
    echo ""
    echo -e "${CYAN}Key Commands:${NC}"
    echo -e "${YELLOW}•${NC} File Explorer: ${BLUE}<Space>e${NC}"
    echo -e "${YELLOW}•${NC} Find Files: ${BLUE}<Space>ff${NC}"
    echo -e "${YELLOW}•${NC} Git Interface: ${BLUE}<Space>gg${NC}"
    echo -e "${YELLOW}•${NC} Python Venv: ${BLUE}<Space>vs${NC}"
    echo ""
    echo -e "${CYAN}To Restore Original Config:${NC}"
    echo -e "${BLUE}bash ~/.config/restore_original_nvim.sh${NC}"
    echo ""
    echo -e "${PURPLE}Happy coding with SuperVim! 🎉${NC}"
}

main "$@"