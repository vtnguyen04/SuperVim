#!/bin/bash

# Quick setup without interactive prompts
echo "🚀 Setting up SuperVim automatically..."

# Backup current config if exists
if [ -d "$HOME/.config/nvim" ]; then
    BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Backing up current config to $BACKUP_DIR"
    mv "$HOME/.config/nvim" "$BACKUP_DIR"

    # Backup data
    if [ -d "$HOME/.local/share/nvim" ]; then
        DATA_BACKUP="$HOME/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$HOME/.local/share/nvim" "$DATA_BACKUP"
        echo "📦 Neovim data backed up to $DATA_BACKUP"
    fi
fi

# Install SuperVim
echo "⚙️  Installing SuperVim..."
mkdir -p "$HOME/.config"
cp -r /home/quynhthu/Documents/SuperVim "$HOME/.config/nvim"

echo "✅ SuperVim installed successfully!"
echo ""
echo "🎯 Quick Start:"
echo "   nvim                    # Launch Neovim"
echo "   <Space>ff              # Find files"
echo "   <Space>e               # File explorer"
echo ""
echo "📁 Test with demo file:"
echo "   nvim ~/Documents/SuperVim/demo.py"