#!/bin/bash

# =============================================================================
# SuperVim Installation Script
# A comprehensive Neovim configuration that rivals VSCode
# =============================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Symbols
SUCCESS="✅"
ERROR="❌"
INFO="ℹ️"
WARNING="⚠️"
ROCKET="🚀"
GEAR="⚙️"

# Global variables
SUPERVIM_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
LOG_FILE="/tmp/supervim_install.log"

# =============================================================================
# Helper Functions
# =============================================================================

print_header() {
    echo -e "${PURPLE}"
    echo "██████╗ ██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗"
    echo "██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██║████╗ ████║"
    echo "███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║██║██╔████╔██║"
    echo "╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║"
    echo "███████║╚██████╔╝██║     ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║"
    echo "╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}SuperVim - VSCode Alternative for Neovim${NC}"
    echo -e "${YELLOW}Version 2.0 | Modern • Fast • Beautiful${NC}"
    echo ""
}

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_FILE"
}

print_info() {
    echo -e "${BLUE}${INFO} $1${NC}"
    log "INFO: $1"
}

print_success() {
    echo -e "${GREEN}${SUCCESS} $1${NC}"
    log "SUCCESS: $1"
}

print_warning() {
    echo -e "${YELLOW}${WARNING} $1${NC}"
    log "WARNING: $1"
}

print_error() {
    echo -e "${RED}${ERROR} $1${NC}"
    log "ERROR: $1"
}

print_step() {
    echo -e "${PURPLE}${GEAR} $1${NC}"
    log "STEP: $1"
}

# =============================================================================
# System Detection and Prerequisites
# =============================================================================

detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        if command -v apt &> /dev/null; then
            DISTRO="debian"
        elif command -v pacman &> /dev/null; then
            DISTRO="arch"
        elif command -v dnf &> /dev/null; then
            DISTRO="fedora"
        else
            DISTRO="unknown"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        DISTRO="macos"
    else
        OS="unknown"
        DISTRO="unknown"
    fi
    print_info "Detected OS: $OS ($DISTRO)"
}

check_prerequisites() {
    print_step "Checking prerequisites..."

    local missing_deps=()

    # Check for essential tools
    command -v git &> /dev/null || missing_deps+=("git")
    command -v curl &> /dev/null || missing_deps+=("curl")

    # Check Neovim version
    if command -v nvim &> /dev/null; then
        local nvim_version=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+')
        local major=$(echo $nvim_version | cut -d. -f1)
        local minor=$(echo $nvim_version | cut -d. -f2)

        if [ "$major" -eq 0 ] && [ "$minor" -lt 9 ]; then
            print_warning "Neovim version $nvim_version detected. Version 0.9+ recommended."
        else
            print_success "Neovim version $nvim_version detected"
        fi
    else
        missing_deps+=("neovim")
    fi

    # Check optional but recommended tools
    if ! command -v node &> /dev/null; then
        print_warning "Node.js not found. Some LSP servers require Node.js"
    else
        print_success "Node.js $(node --version) detected"
    fi

    if ! command -v python3 &> /dev/null; then
        print_warning "Python 3 not found. Python support will be limited"
    else
        print_success "Python $(python3 --version) detected"
    fi

    if ! command -v rg &> /dev/null; then
        print_warning "ripgrep not found. Text search will use fallback"
    else
        print_success "ripgrep detected"
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        print_info "Please install them and run this script again"
        show_install_commands "${missing_deps[@]}"
        exit 1
    fi

    print_success "All prerequisites satisfied"
}

show_install_commands() {
    local deps=("$@")
    print_info "Installation commands for your system:"

    case "$DISTRO" in
        "debian")
            echo -e "${YELLOW}sudo apt update && sudo apt install -y ${deps[*]}${NC}"
            ;;
        "arch")
            echo -e "${YELLOW}sudo pacman -S ${deps[*]}${NC}"
            ;;
        "fedora")
            echo -e "${YELLOW}sudo dnf install -y ${deps[*]}${NC}"
            ;;
        "macos")
            echo -e "${YELLOW}brew install ${deps[*]}${NC}"
            ;;
        *)
            print_info "Please install the missing dependencies using your package manager"
            ;;
    esac
}

# =============================================================================
# Installation Functions
# =============================================================================

backup_existing_config() {
    if [ -d "$SUPERVIM_DIR" ]; then
        print_step "Backing up existing Neovim configuration..."

        if mv "$SUPERVIM_DIR" "$BACKUP_DIR"; then
            print_success "Backup created at $BACKUP_DIR"
        else
            print_error "Failed to backup existing configuration"
            exit 1
        fi

        # Also backup data directory
        local data_dir="$HOME/.local/share/nvim"
        if [ -d "$data_dir" ]; then
            local data_backup="${data_dir}.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$data_dir" "$data_backup"
            print_info "Neovim data backed up to $data_backup"
        fi
    fi
}

install_supervim() {
    print_step "Installing SuperVim configuration..."

    # Create config directory
    mkdir -p "$(dirname "$SUPERVIM_DIR")"

    # Check if we're already in the SuperVim directory
    if [ "$(pwd)" != "$SUPERVIM_DIR" ] && [ ! -d "$SUPERVIM_DIR/.git" ]; then
        # Clone the repository
        if git clone --depth 1 https://github.com/vtnguyen04/SuperVim.git "$SUPERVIM_DIR"; then
            print_success "SuperVim downloaded successfully"
        else
            # Fallback: copy current directory if this script is run from SuperVim directory
            if [ -f "$(pwd)/init.lua" ]; then
                print_info "Using local SuperVim configuration"
                cp -r "$(pwd)" "$SUPERVIM_DIR"
            else
                print_error "Failed to download SuperVim"
                exit 1
            fi
        fi
    else
        print_info "Using existing SuperVim configuration"
    fi
}

install_nerd_fonts() {
    print_step "Installing Nerd Fonts..."

    local font_dir
    if [[ "$OS" == "macos" ]]; then
        font_dir="$HOME/Library/Fonts"
    else
        font_dir="$HOME/.local/share/fonts"
    fi

    mkdir -p "$font_dir"

    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
    local temp_dir=$(mktemp -d)

    if curl -L -o "$temp_dir/JetBrainsMono.zip" "$font_url" && \
       unzip -q "$temp_dir/JetBrainsMono.zip" -d "$temp_dir" && \
       cp "$temp_dir"/*.ttf "$font_dir/" 2>/dev/null; then

        # Refresh font cache on Linux
        if [[ "$OS" == "linux" ]]; then
            command -v fc-cache &> /dev/null && fc-cache -fv "$font_dir" &>/dev/null
        fi

        print_success "JetBrainsMono Nerd Font installed"
        print_info "Please set your terminal font to 'JetBrainsMono Nerd Font'"
    else
        print_warning "Failed to install Nerd Font. Please install manually from https://www.nerdfonts.com/"
    fi

    rm -rf "$temp_dir"
}

install_additional_tools() {
    print_step "Installing additional development tools..."

    # Install language servers and tools via Mason (will be done by Mason in Neovim)
    print_info "Language servers will be installed automatically by Mason when you first use Neovim"

    # Install ripgrep if not present
    if ! command -v rg &> /dev/null; then
        case "$DISTRO" in
            "debian")
                if curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb; then
                    sudo dpkg -i ripgrep_13.0.0_amd64.deb && rm ripgrep_13.0.0_amd64.deb
                    print_success "ripgrep installed"
                fi
                ;;
            "arch")
                sudo pacman -S ripgrep --noconfirm && print_success "ripgrep installed"
                ;;
            "fedora")
                sudo dnf install -y ripgrep && print_success "ripgrep installed"
                ;;
            "macos")
                brew install ripgrep && print_success "ripgrep installed"
                ;;
        esac
    fi

    # Install fd-find if available
    if ! command -v fd &> /dev/null; then
        case "$DISTRO" in
            "debian")
                sudo apt install -y fd-find &>/dev/null && print_success "fd-find installed"
                ;;
            "arch"|"fedora"|"macos")
                command -v pacman &> /dev/null && sudo pacman -S fd --noconfirm &>/dev/null
                command -v dnf &> /dev/null && sudo dnf install -y fd-find &>/dev/null
                command -v brew &> /dev/null && brew install fd &>/dev/null
                print_success "fd installed"
                ;;
        esac
    fi
}

setup_python_environment() {
    if command -v python3 &> /dev/null; then
        print_step "Setting up Python development environment..."

        # Install essential Python packages
        python3 -m pip install --user --upgrade pip setuptools wheel &>/dev/null || true
        python3 -m pip install --user debugpy black isort flake8 mypy &>/dev/null || true

        print_success "Python development tools installed"
    fi
}

# =============================================================================
# Post-installation
# =============================================================================

create_desktop_entry() {
    if [[ "$OS" == "linux" ]]; then
        print_step "Creating desktop entry..."

        local desktop_file="$HOME/.local/share/applications/supervim.desktop"
        mkdir -p "$(dirname "$desktop_file")"

        cat > "$desktop_file" << EOF
[Desktop Entry]
Name=SuperVim
Comment=Modern Neovim Configuration
Exec=nvim
Icon=nvim
Type=Application
Categories=Development;TextEditor;
Terminal=true
StartupNotify=true
EOF

        print_success "Desktop entry created"
    fi
}

setup_shell_aliases() {
    print_step "Setting up shell aliases..."

    local shell_rc
    if [[ "$SHELL" == *"zsh"* ]]; then
        shell_rc="$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        shell_rc="$HOME/.bashrc"
    else
        print_info "Unknown shell. Skipping alias setup."
        return
    fi

    if [ -f "$shell_rc" ]; then
        # Add SuperVim aliases if not already present
        if ! grep -q "# SuperVim aliases" "$shell_rc"; then
            cat >> "$shell_rc" << 'EOF'

# SuperVim aliases
alias vim='nvim'
alias vi='nvim'
alias svim='nvim'
EOF
            print_success "Shell aliases added to $shell_rc"
            print_info "Run 'source $shell_rc' or restart your terminal to use aliases"
        fi
    fi
}

first_run_setup() {
    print_step "Performing first-time setup..."

    print_info "Running initial Neovim setup (this may take a few minutes)..."
    print_info "Installing plugins with Lazy.nvim..."

    # Use Lazy.nvim commands for plugin installation
    nvim --headless "+Lazy! sync" +qa &>/dev/null || true

    print_info "Setting up LSP servers with Mason..."
    nvim --headless "+MasonInstallAll" +qa &>/dev/null || true
    print_success "Initial setup completed"
}

show_completion_message() {
    echo ""
    echo -e "${GREEN}${ROCKET} SuperVim installation completed successfully!${NC}"
    echo ""
    echo -e "${CYAN}Quick Start:${NC}"
    echo -e "${YELLOW}1.${NC} Launch Neovim: ${BLUE}nvim${NC}"
    echo -e "${YELLOW}2.${NC} Wait for plugins to install (first launch only)"
    echo -e "${YELLOW}3.${NC} Press ${BLUE}<Space>ff${NC} to find files"
    echo -e "${YELLOW}4.${NC} Press ${BLUE}<Space>e${NC} to open file explorer"
    echo -e "${YELLOW}5.${NC} Press ${BLUE}<Space>gg${NC} to open LazyGit"
    echo ""
    echo -e "${CYAN}Key Features:${NC}"
    echo -e "${YELLOW}•${NC} File Explorer: ${BLUE}<Space>e${NC}"
    echo -e "${YELLOW}•${NC} Find Files: ${BLUE}<Space>ff${NC}"
    echo -e "${YELLOW}•${NC} Find Text: ${BLUE}<Space>fg${NC}"
    echo -e "${YELLOW}•${NC} Python Venv: ${BLUE}<Space>vs${NC}"
    echo -e "${YELLOW}•${NC} Git Interface: ${BLUE}<Space>gg${NC}"
    echo -e "${YELLOW}•${NC} Toggle Terminal: ${BLUE}Ctrl+\\${NC}"
    echo ""
    echo -e "${CYAN}Documentation:${NC} $SUPERVIM_DIR/README.md"
    echo -e "${CYAN}Configuration:${NC} $SUPERVIM_DIR/lua/"
    echo -e "${CYAN}Log File:${NC} $LOG_FILE"
    echo ""
    echo -e "${PURPLE}Happy coding with SuperVim! 🎉${NC}"
}

# =============================================================================
# Main Installation Flow
# =============================================================================

main() {
    clear
    print_header

    # Initialize log
    echo "SuperVim Installation Log - $(date)" > "$LOG_FILE"

    # Detect system
    detect_os

    # Check prerequisites
    check_prerequisites

    # Confirm installation
    echo -e "${YELLOW}This will install SuperVim to $SUPERVIM_DIR${NC}"
    if [ -d "$SUPERVIM_DIR" ]; then
        echo -e "${RED}Existing configuration will be backed up${NC}"
    fi
    echo ""
    read -p "Continue? (y/N): " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi

    echo ""
    print_step "Starting SuperVim installation..."

    # Installation steps
    backup_existing_config
    install_supervim
    install_nerd_fonts
    install_additional_tools
    setup_python_environment
    create_desktop_entry
    setup_shell_aliases

    print_success "SuperVim installation completed!"

    # Show completion message
    show_completion_message
}

# =============================================================================
# Error Handling and Cleanup
# =============================================================================

cleanup() {
    if [ $? -ne 0 ]; then
        print_error "Installation failed!"
        print_info "Check the log file: $LOG_FILE"
        print_info "You can restore your backup from: $BACKUP_DIR"
    fi
}

trap cleanup EXIT

# =============================================================================
# Script Entry Point
# =============================================================================

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    print_error "This script should not be run as root"
    exit 1
fi

# Run main installation
main "$@"