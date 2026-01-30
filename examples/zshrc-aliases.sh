# Tmux Agentik OS - Example Aliases
# Add these to your ~/.zshrc or ~/.bashrc

# ==========================================
# PATH (if not already set)
# ==========================================
export PATH="$HOME/.local/bin:$PATH"

# ==========================================
# Global Commands
# ==========================================

# Session selector - manage all sessions
alias ts='tmux-select'

# Quick session list
alias tps='tmux ls 2>/dev/null || echo "No sessions"'

# ==========================================
# Project Shortcuts
# ==========================================
# Usage: tmux-project <SessionName> <ProjectPath>
#
# Each alias opens an interactive menu where you can:
# - Attach to existing sessions
# - Create new sessions
# - Delete sessions
# - Clean project caches
# - Init Claude context

# Example projects (customize for your setup!)
alias c-myproject='tmux-project MyProject ~/projects/myproject'
alias c-frontend='tmux-project Frontend ~/projects/frontend'
alias c-backend='tmux-project Backend ~/projects/backend'
alias c-mobile='tmux-project MobileApp ~/projects/mobile-app'

# ==========================================
# Quick Navigation
# ==========================================

# Go to projects directory
alias proj='cd ~/projects'

# ==========================================
# Git + Tmux
# ==========================================

# Quick save (add + commit + push) with session name in message
save() {
    local session_name=$(tmux display-message -p '#S' 2>/dev/null || echo "nosession")
    git add -A
    git commit -m "${1:-WIP from $session_name}"
    git push
}
