#!/bin/bash

# Tmux Agentik OS - Installation Script
# https://github.com/agentik-os/tmux-agentik-os

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_DIR="$HOME/.tmux"
SCRIPTS_DIR="$TMUX_DIR/scripts"
BIN_DIR="$HOME/.local/bin"

echo "╔══════════════════════════════════════════════════════════╗"
echo "║  🚀 Tmux Agentik OS - Installation                       ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Backup existing config
if [ -f "$HOME/.tmux.conf" ]; then
    echo "📦 Backing up existing ~/.tmux.conf to ~/.tmux.conf.backup"
    cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
fi

# Create directories
echo "📁 Creating directories..."
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$BIN_DIR"

# Copy tmux config
echo "📋 Installing tmux.conf..."
cp "$REPO_DIR/tmux.conf" "$HOME/.tmux.conf"

# Copy scripts
echo "📜 Installing scripts..."
cp "$REPO_DIR/scripts/"*.sh "$SCRIPTS_DIR/" 2>/dev/null || true
chmod +x "$SCRIPTS_DIR/"*.sh 2>/dev/null || true

# Copy main executables
if [ -f "$REPO_DIR/scripts/tmux-project" ]; then
    cp "$REPO_DIR/scripts/tmux-project" "$BIN_DIR/"
    chmod +x "$BIN_DIR/tmux-project"
    echo "   ✓ tmux-project installed"
fi

if [ -f "$REPO_DIR/scripts/tmux-select" ]; then
    cp "$REPO_DIR/scripts/tmux-select" "$BIN_DIR/"
    chmod +x "$BIN_DIR/tmux-select"
    echo "   ✓ tmux-select installed"
fi

# Add to PATH if needed
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo ""
    echo "⚠️  Add $BIN_DIR to your PATH by adding this to ~/.zshrc or ~/.bashrc:"
    echo ""
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

# Install TPM if not present
if [ ! -d "$TMUX_DIR/plugins/tpm" ]; then
    echo "📦 Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TMUX_DIR/plugins/tpm"
fi

# Create example aliases
echo ""
echo "📝 Example aliases to add to your ~/.zshrc:"
echo ""
echo "    # Global selector"
echo "    alias ts='tmux-select'"
echo "    alias tps='tmux ls 2>/dev/null || echo \"No sessions\"'"
echo ""
echo "    # Project shortcuts (customize paths!)"
echo "    alias c-myproject='tmux-project MyProject /path/to/myproject'"
echo "    alias c-another='tmux-project Another /path/to/another'"
echo ""

# Reload tmux if running
if tmux list-sessions &>/dev/null; then
    echo "🔄 Reloading tmux configuration..."
    tmux source-file "$HOME/.tmux.conf"
    echo "   ✓ Config reloaded!"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅ Installation complete!                               ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "Shortcuts:"
echo "  ⌥ Z  - List sessions & windows"
echo "  ⌥ X  - Previous session"
echo "  ⌥ V  - Next session"
echo "  ⌥ K  - Kill session"
echo "  ⌥ N  - New window"
echo ""
echo "Commands:"
echo "  ts   - Global session selector"
echo "  tps  - Quick session list"
echo ""
echo "Enjoy! 🎉"
