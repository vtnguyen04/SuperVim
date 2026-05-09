#!/bin/bash

# SuperVim Screenshots Generator
# This script helps generate screenshots for documentation

set -e

echo "🚀 SuperVim Screenshots Generator"
echo "================================="

# Check if running in a GUI environment
if [ -z "${DISPLAY}" ]; then
    echo "❌ Error: No GUI display detected. Please run in a graphical environment."
    exit 1
fi

# Check if scrot is available for screenshots
if ! command -v scrot &> /dev/null; then
    echo "📦 Installing scrot for screenshots..."
    sudo apt-get update && sudo apt-get install -y scrot
fi

# Create screenshots directory
mkdir -p assets/screenshots

echo "📷 Ready to generate screenshots!"
echo ""
echo "Instructions:"
echo "1. Open Neovim with SuperVim configuration"
echo "2. Set up each scenario described below"
echo "3. Press ENTER when ready to capture each screenshot"
echo ""

read -p "Press ENTER to start generating screenshots..."

# Dashboard screenshot
echo "🏠 Generating dashboard.png..."
echo "Instructions:"
echo "- Open nvim without any file (shows Alpha dashboard)"
echo "- Ensure Tokyo Night theme is active"
echo "- Make sure the welcome screen is visible"
echo ""
read -p "Press ENTER when ready to capture dashboard..."
scrot -s 'assets/screenshots/dashboard.png' -q 100
echo "✅ Dashboard screenshot saved!"

# Coding experience
echo ""
echo "💻 Generating coding.png..."
echo "Instructions:"
echo "- Open a Python file with some code"
echo "- Show LSP autocompletion or diagnostics"
echo "- Include syntax highlighting and line numbers"
echo ""
read -p "Press ENTER when ready to capture coding experience..."
scrot -s 'assets/screenshots/coding.png' -q 100
echo "✅ Coding screenshot saved!"

# Telescope
echo ""
echo "🔍 Generating telescope.png..."
echo "Instructions:"
echo "- Open Telescope with <leader>ff or <leader>fg"
echo "- Show the fuzzy finder interface"
echo "- Include search results"
echo ""
read -p "Press ENTER when ready to capture Telescope..."
scrot -s 'assets/screenshots/telescope.png' -q 100
echo "✅ Telescope screenshot saved!"

# Neo-tree
echo ""
echo "🌳 Generating neotree.png..."
echo "Instructions:"
echo "- Open Neo-tree with <leader>e"
echo "- Show file tree with Git status"
echo "- Include file icons and folder structure"
echo ""
read -p "Press ENTER when ready to capture Neo-tree..."
scrot -s 'assets/screenshots/neotree.png' -q 100
echo "✅ Neo-tree screenshot saved!"

# Debugging
echo ""
echo "🐛 Generating debugging.png..."
echo "Instructions:"
echo "- Set up a debugging session with DAP"
echo "- Show breakpoints, variables, or call stack"
echo "- Include debugging interface"
echo ""
read -p "Press ENTER when ready to capture debugging..."
scrot -s 'assets/screenshots/debugging.png' -q 100
echo "✅ Debugging screenshot saved!"

echo ""
echo "🎉 All screenshots generated successfully!"
echo "📁 Screenshots saved in: assets/screenshots/"
echo ""
echo "Next steps:"
echo "1. Review the screenshots for quality"
echo "2. Commit and push to update README"
echo "3. Screenshots will automatically appear in GitHub README"